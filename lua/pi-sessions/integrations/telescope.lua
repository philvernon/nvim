local M = {}

function M.open()
	local core = require("pi-sessions")
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	local conf = require("telescope.config").values
	local finders = require("telescope.finders")
	local pickers = require("telescope.pickers")
	local previewers = require("telescope.previewers")

	local rows = {}
	for _, project in ipairs(core.scan().projects) do
		for _, session in ipairs(project.sessions) do
			rows[#rows + 1] = { project = project, session = session }
		end
	end

	pickers.new({}, {
		prompt_title = "Pi sessions",
		finder = finders.new_table({
			results = rows,
			entry_maker = function(row)
				return {
					value = row,
					display = ("%s  %s"):format(row.project.name, row.session.label),
					ordinal = table.concat({
						row.project.cwd,
						row.session.name or "",
						row.session.timestamp or "",
					}, " "),
				}
			end,
		}),
		sorter = conf.generic_sorter({}),
		previewer = previewers.new_buffer_previewer({
			define_preview = function(self, entry)
				vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, core.preview(entry.value.session))
				vim.bo[self.state.bufnr].filetype = "markdown"
			end,
		}),
		attach_mappings = function(bufnr, map)
			local function selected()
				local entry = action_state.get_selected_entry()
				return entry and entry.value
			end
			actions.select_default:replace(function()
				local row = selected()
				if row then
					actions.close(bufnr)
					core.resume(row.session)
				end
			end)
			local function new()
				local row = selected()
				if row then
					actions.close(bufnr)
					core.new(row.project)
				end
			end
			map("i", "<C-n>", new)
			map("n", "n", new)
			return true
		end,
	}):find()
end

return M
