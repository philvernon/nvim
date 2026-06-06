local clrs = require("catppuccin.palettes").get_palette()

return {
	"pwntester/octo.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-tree/nvim-web-devicons", -- optional if file_panel.icons is a function
	},
	event = "VeryLazy",
	opts = {
		-- or "fzf-lua" or "snacks" or "default"
		default_to_projects_v2 = true,
		picker = "telescope",
		-- bare Octo command opens picker of commands
		enable_builtin = true,
		highlights = {
			octo_link = { fg = clrs.surface0 },
		},
	},
}
