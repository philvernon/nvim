return {
	{ "j-hui/fidget.nvim" },
	{ "williamboman/mason-lspconfig.nvim", lazy = false },
	{ "neovim/nvim-lspconfig", lazy = false },
	{ "mrcjkb/rustaceanvim", version = "^9", lazy = false },
	{ "famiu/bufdelete.nvim" },
	{ "NeogitOrg/neogit", config = true },
	{ "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
	{ "MeanderingProgrammer/render-markdown.nvim", dependencies = { "nvim-mini/mini.nvim" } },
	{ "tyru/open-browser.vim", lazy = true },
	{ "opdavies/toggle-checkbox.nvim" },
	{ "tpope/vim-dadbod" },
	{ "folke/snacks.nvim" },
	{ "carderne/pi-nvim", lazy = false, config = function() require("pi-nvim").setup() end },
	{ "bullets-vim/bullets.vim" },
	{ "nvim-mini/mini.comment", version = false, config = function() require("mini.comment").setup() end },
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
	{
		"folke/sidekick.nvim",
		opts = {
			-- add any options here
			cli = {
				mux = {
					backend = "tmux",
					enabled = true,
				},
			},
		},
		keys = {
			{
				"<tab>",
				function()
					-- if there is a next edit, jump to it, otherwise apply it if any
					if not require("sidekick").nes_jump_or_apply() then
						return "<Tab>" -- fallback to normal tab
					end
				end,
				expr = true,
				desc = "Goto/Apply Next Edit Suggestion",
			},
			{
				"<c-.>",
				function() require("sidekick.cli").focus() end,
				desc = "Sidekick Focus",
				mode = { "n", "t", "i", "x" },
			},
			{
				"<leader>aa",
				function() require("sidekick.cli").toggle() end,
				desc = "Sidekick Toggle CLI",
			},
			{
				"<leader>as",
				function() require("sidekick.cli").select() end,
				-- Or to select only installed tools:
				-- require("sidekick.cli").select({ filter = { installed = true } })
				desc = "Select CLI",
			},
			{
				"<leader>ad",
				function() require("sidekick.cli").close() end,
				desc = "Detach a CLI Session",
			},
			{
				"<leader>at",
				function() require("sidekick.cli").send({ msg = "{this}" }) end,
				mode = { "x", "n" },
				desc = "Send This",
			},
			{
				"<leader>af",
				function() require("sidekick.cli").send({ msg = "{file}" }) end,
				desc = "Send File",
			},
			{
				"<leader>av",
				function() require("sidekick.cli").send({ msg = "{selection}" }) end,
				mode = { "x" },
				desc = "Send Visual Selection",
			},
			{
				"<leader>ap",
				function() require("sidekick.cli").prompt() end,
				mode = { "n", "x" },
				desc = "Sidekick Select Prompt",
			},
			-- Example of a keybinding to open Claude directly
			{
				"<leader>ac",
				function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
				desc = "Sidekick Toggle Claude",
			},
		},
	},
}
