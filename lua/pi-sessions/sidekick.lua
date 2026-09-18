local M = {}

local tool_prefix = "pi-s-"
local active_window
local patched = false

local sidekick_window_options = {
	"winhighlight",
	"colorcolumn",
	"cursorcolumn",
	"cursorline",
	"fillchars",
	"list",
	"listchars",
	"number",
	"relativenumber",
	"sidescrolloff",
	"signcolumn",
	"statuscolumn",
	"spell",
	"winbar",
	"wrap",
}

local function tool_name(id)
	return tool_prefix .. vim.fn.sha256(id):sub(1, 10)
end

local function valid_window(win)
	return win and vim.api.nvim_win_is_valid(win)
end

local function client_window()
	local win = vim.t.pi_sessions_client_win
	return valid_window(win) and win or nil
end

local function restore_window(terminal)
	local win = terminal.win
	if valid_window(win) and vim.api.nvim_win_get_buf(win) == terminal.buf then
		local previous = terminal._pi_sessions_previous_buf
		if not previous or not vim.api.nvim_buf_is_valid(previous) or previous == terminal.buf then
			previous = vim.api.nvim_create_buf(true, false)
		end
		if vim.api.nvim_get_current_win() == win then
			vim.cmd.stopinsert()
		end
		vim.api.nvim_win_set_buf(win, previous)
		for name, value in pairs(terminal._pi_sessions_previous_wo or {}) do
			vim.wo[win][name] = value
		end
	end

	if valid_window(win) and vim.w[win].sidekick_session_id == terminal.id then
		vim.w[win].sidekick_cli = nil
		vim.w[win].sidekick_session_id = nil
	end

	terminal.win = nil
	terminal._pi_sessions_embedded = nil
	terminal._pi_sessions_previous_buf = nil
	terminal._pi_sessions_previous_wo = nil
end

local function patch_terminal()
	if patched then
		return
	end
	patched = true

	local Terminal = require("sidekick.cli.terminal")
	local open_win = Terminal.open_win
	local hide = Terminal.hide

	function Terminal:open_win()
		local target = active_window
		if not valid_window(target) then
			return open_win(self)
		end
		if not self.buf then
			return
		end
		if self.win == target and self:is_open() then
			return
		end

		if self:is_open() then
			if self._pi_sessions_embedded then
				restore_window(self)
			else
				pcall(vim.api.nvim_win_close, self.win, true)
				self.win = nil
			end
		end

		self._pi_sessions_previous_buf = vim.api.nvim_win_get_buf(target)
		self._pi_sessions_previous_wo = {}
		for _, name in ipairs(sidekick_window_options) do
			self._pi_sessions_previous_wo[name] = vim.wo[target][name]
		end
		for name in pairs(self.opts.wo or {}) do
			if self._pi_sessions_previous_wo[name] == nil then
				self._pi_sessions_previous_wo[name] = vim.wo[target][name]
			end
		end
		self._pi_sessions_embedded = true
		self.win = target

		vim.api.nvim_win_set_buf(target, self.buf)
		vim.w[target].sidekick_cli = self.tool
		vim.w[target].sidekick_session_id = self.id
		self:wo()
	end

	function Terminal:hide()
		if self._pi_sessions_embedded then
			restore_window(self)
			return self
		end
		return hide(self)
	end
end

local function with_client_window(fn)
	patch_terminal()
	local previous = active_window
	active_window = client_window()
	local result = { pcall(fn) }
	active_window = previous
	if not result[1] then
		error(result[2], 0)
	end
	return unpack(result, 2)
end

local function switch_attached_pi(State, name)
	local target
	for _, state in ipairs(State.get({ attached = true })) do
		local state_name = state.tool and state.tool.name
		if state_name == name then
			target = state
		elseif state_name == "pi" or (state_name and vim.startswith(state_name, tool_prefix)) then
			State.detach(state)
		end
	end
	return target
end

local function launch(cwd, args, name)
	return with_client_window(function()
		local Config = require("sidekick.config")
		local Session = require("sidekick.cli.session")
		local State = require("sidekick.cli.state")

		Session.setup()

		local tool = Config.get_tool("pi")
		local cmd = vim.deepcopy(tool.cmd)
		vim.list_extend(cmd, args or {})
		tool = tool:clone({ cmd = cmd, name = name or tool.name })

		local attached = switch_attached_pi(State, name)
		if attached then
			return State.attach(attached, { show = true, focus = true })
		end

		local session = Session.new({
			tool = tool,
			cwd = cwd,
		})

		return State.attach(State.get_state(session), { show = true, focus = true })
	end)
end

function M.set_client_window(win)
	assert(valid_window(win), "invalid PiClient window")
	vim.t.pi_sessions_client_win = win
end

function M.resume(session)
	return launch(session.cwd, { "--session", session.path }, tool_name(session.id))
end

function M.new(cwd)
	return launch(cwd, {})
end

return M
