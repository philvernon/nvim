return {
	"pwntester/octo.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "https://github.com/junegunn/g.vim" },
	event = "VeryLazy",
	config = function()
		local clrs = require("catppuccin.palettes").get_palette()

		require("octo").setup({
			default_to_projects_v2 = true,
			highlights = {
				octo_link = { fg = clrs.surface0 },
			},
		})
	end,
}
