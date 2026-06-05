local clrs = require("catppuccin.palettes").get_palette()

local LuaLineHighlights = {
	OctoEditable = { bg = clrs.surface0 }, -- Color for inactive window.
}

for hl, col in pairs(LuaLineHighlights) do
	vim.api.nvim_set_hl(0, hl, col)
end

require("octo").setup({
	default_to_projects_v2 = true,
})
