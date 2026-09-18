local M = {}

local function root()
	return vim.fs.normalize(vim.env.PI_CODING_AGENT_SESSION_DIR or vim.fn.expand("~/.pi/agent/sessions"))
end

local function timestamp(ts)
	if not ts or ts == "" then
		return "unknown"
	end
	return ts:gsub("T", " "):gsub("%.000Z$", "Z")
end

local function message_text(message)
	if type(message) ~= "table" or message.role ~= "user" then
		return
	end
	if type(message.content) == "string" then
		return message.content
	end
	if type(message.content) == "table" then
		local text = {}
		for _, part in ipairs(message.content) do
			if type(part) == "table" and part.type == "text" and type(part.text) == "string" then
				text[#text + 1] = part.text
			end
		end
		return table.concat(text, " ")
	end
end

local function read_session(path)
	local file = io.open(path, "r")
	if not file then
		return
	end

	local header, name, first_message
	for line in file:lines() do
		local ok, item = pcall(vim.json.decode, line)
		if ok and type(item) == "table" then
			if not header and item.type == "session" then
				header = item
			elseif item.type == "session_info" then
				name = type(item.name) == "string" and vim.trim(item.name) or nil
				if name == "" then
					name = nil
				end
			elseif not first_message and item.type == "message" then
				first_message = message_text(item.message)
			end
		end
	end
	file:close()

	if not header or not header.cwd or not header.id then
		return
	end

	name = name or header.name or header.title or first_message
	if name then
		name = name:gsub("%s+", " ")
	end
	local session = {
		id = header.id,
		path = path,
		cwd = header.cwd,
		timestamp = header.timestamp,
		name = name,
	}
	session.label = ("%s  %s"):format(name or header.id:sub(1, 8), timestamp(header.timestamp))
	return session
end

function M.root()
	return root()
end

function M.scan()
	local sessions = {}
	for _, path in ipairs(vim.fn.globpath(root(), "**/*.jsonl", false, true)) do
		local session = read_session(path)
		if session then
			sessions[#sessions + 1] = session
		end
	end

	table.sort(sessions, function(a, b)
		return (a.timestamp or "") > (b.timestamp or "")
	end)

	local by_cwd, projects = {}, {}
	for _, session in ipairs(sessions) do
		local project = by_cwd[session.cwd]
		if not project then
			project = {
				cwd = session.cwd,
				name = vim.fn.fnamemodify(session.cwd, ":~"),
				sessions = {},
			}
			by_cwd[session.cwd] = project
			projects[#projects + 1] = project
		end
		project.sessions[#project.sessions + 1] = session
	end

	return { sessions = sessions, projects = projects }
end

function M.all()
	return M.scan().sessions
end

function M.projects()
	return M.scan().projects
end

function M.sessions(project)
	local cwd = type(project) == "table" and project.cwd or project
	for _, item in ipairs(M.scan().projects) do
		if item.cwd == cwd then
			return item.sessions
		end
	end
	return {}
end

local function launch(cwd, args)
	local Config = require("sidekick.config")
	local Session = require("sidekick.cli.session")
	local State = require("sidekick.cli.state")

	Session.setup()

	local tool = Config.get_tool("pi")
	local cmd = vim.deepcopy(tool.cmd or { "pi" })
	vim.list_extend(cmd, args or {})

	local session = Session.new({
		tool = tool:clone({ cmd = cmd }),
		cwd = cwd,
	})

	return State.attach(State.get_state(session), { show = true, focus = true })
end

function M.resume(session)
	assert(session and session.path and session.cwd, "invalid Pi session")
	return launch(session.cwd, { "--session", session.path })
end

function M.new(project)
	local cwd = type(project) == "table" and project.cwd or project
	assert(cwd and cwd ~= "", "invalid Pi project")
	return launch(cwd, {})
end

function M.setup(opts)
	opts = opts or {}
	vim.api.nvim_create_user_command("PiSessions", function(cmd)
		local integration = cmd.args ~= "" and cmd.args or opts.integration or "neo-tree"
		if integration == "neotree" then
			integration = "neo-tree"
		end
		require("pi-sessions.integrations." .. integration).open()
	end, {
		nargs = "?",
		force = true,
		complete = function()
			return { "neo-tree", "telescope" }
		end,
	})
end

return M
