return {
	{ "j-hui/fidget.nvim" },

	{ "famiu/bufdelete.nvim" },
	{ "NeogitOrg/neogit", config = true },
	{ "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
	{ "MeanderingProgrammer/render-markdown.nvim", dependencies = { "nvim-mini/mini.nvim" } },
	{ "tyru/open-browser.vim", lazy = true },
	{ "opdavies/toggle-checkbox.nvim" },
	{ "tpope/vim-dadbod" },
	{ "folke/snacks.nvim" },
	{ "carderne/pi-nvim", config = function() require("pi-nvim").setup() end },
}
