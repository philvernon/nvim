return {
	{ "j-hui/fidget.nvim" },
	{ "williamboman/mason-lspconfig.nvim", lazy = false },
	{ "neovim/nvim-lspconfig", lazy = false },
	{
		"mrcjkb/rustaceanvim",
		version = "^9", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
	"famiu/bufdelete.nvim",
	{ "NeogitOrg/neogit", config = true },
	{ "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
	{
		"andrewferrier/debugprint.nvim",
		config = function()
			require("debugprint").setup()
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-mini/mini.nvim" },
	},
	{ "tyru/open-browser.vim", lazy = true },
	{
		"shellRaining/hlchunk.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local clrs = require("catppuccin.palettes").get_palette()

			require("hlchunk").setup({
				chunk = {
					style = {
						{ fg = clrs.surface1 },
						{ fg = clrs.surface1 },
					},
					enable = true,
					chars = {
						right_arrow = "",
					},
					delay = 100,
					duration = 0,
				},
			})
		end,
	},
	{
		"linrongbin16/gitlinker.nvim",
		cmd = "GitLink",
		opts = {},
		keys = {
			{ "<leader>gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank git link" },
			{ "<leader>gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
		},
	},
	"opdavies/toggle-checkbox.nvim",
	"tpope/vim-dadbod",
	{ "folke/snacks.nvim" },
	{
		"carderne/pi-nvim",
		config = function()
			require("pi-nvim").setup()
		end,
	},
	{
		"carderne/pi-nvim",
		config = function()
			require("pi-nvim").setup()
		end,
	},
}
