return {
	{ "j-hui/fidget.nvim" },
	{ "williamboman/mason-lspconfig.nvim", lazy = false },
	{ "neovim/nvim-lspconfig", lazy = false },
	{ "mrcjkb/rustaceanvim", version = "^9", lazy = false },
	{ "famiu/bufdelete.nvim" },
	{ "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
	{ "MeanderingProgrammer/render-markdown.nvim", dependencies = { "nvim-mini/mini.nvim" } },
	{ "tyru/open-browser.vim", lazy = true },
	{ "opdavies/toggle-checkbox.nvim" },
	{ "tpope/vim-dadbod" },
	{ "folke/snacks.nvim" },
	{ "carderne/pi-nvim", lazy = false, config = function() require("pi-nvim").setup() end },
	{ "bullets-vim/bullets.vim" },
	{ "nvim-mini/mini.comment", version = false, config = function() require("mini.comment").setup() end },
	{ "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },
	{
		"esmuellert/codediff.nvim",
		cmd = "CodeDiff",
	},
	{
		"zk-org/zk-nvim",
		name = "zk",
		opts = {
			-- See Setup section below
			picker = "telescope",
		},
	},
	{
		"jakewvincent/mkdnflow.nvim",
		config = function() require("mkdnflow").setup({}) end,
	},
}
