local M = {}

function M.open()
	local cwd = vim.uv.cwd()
	local buf = vim.api.nvim_get_current_buf()
	local empty = #vim.api.nvim_tabpage_list_wins(0) == 1
		and vim.api.nvim_buf_get_name(buf) == ""
		and vim.bo[buf].buftype == ""
		and not vim.bo[buf].modified

	if not empty then
		vim.cmd.tabnew()
	end

	local placeholder = vim.api.nvim_get_current_win()
	local placeholder_buf = vim.api.nvim_get_current_buf()

	require("pi-sessions").new(cwd)

	local agent = vim.api.nvim_get_current_win()
	if agent ~= placeholder
		and vim.api.nvim_win_is_valid(placeholder)
		and vim.api.nvim_win_get_buf(placeholder) == placeholder_buf
		and vim.api.nvim_buf_get_name(placeholder_buf) == ""
		and vim.bo[placeholder_buf].buftype == ""
		and not vim.bo[placeholder_buf].modified
	then
		vim.api.nvim_win_close(placeholder, true)
	end

	require("neo-tree.command").execute({
		action = "focus",
		source = "pi_sessions",
		position = "left",
	})

	if vim.api.nvim_win_is_valid(agent) then
		vim.api.nvim_set_current_win(agent)
	end
end

return M
