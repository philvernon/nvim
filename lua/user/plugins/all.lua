return {
	"davidgranstrom/scnvim",
	{ "j-hui/fidget.nvim" },
	"nvim-lua/plenary.nvim",
	"JoosepAlviste/nvim-ts-context-commentstring",
	{
		"artemave/workspace-diagnostics.nvim",
		config = function()
			require("workspace-diagnostics").setup({
				workspace_files = function()
					return vim.fn.systemlist("git ls-files") -- Example to get files from Git.
				end,
			})
		end,
	},
	{ "williamboman/mason-lspconfig.nvim", lazy = false },
	{ "neovim/nvim-lspconfig",             lazy = false },
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
	{
		"folke/neodev.nvim",
		opts = {},
		config = function()
			require("neodev").setup()
		end,
	},
	"rafamadriz/friendly-snippets",
	"saadparwaiz1/cmp_luasnip",
	{ "kevinhwang91/nvim-ufo",  dependencies = "kevinhwang91/promise-async" },
	"famiu/bufdelete.nvim",
	"lukas-reineke/indent-blankline.nvim",
	"tpope/vim-fugitive",
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed, not both.
			"nvim-telescope/telescope.nvim", -- optional
		},
		config = true,
	},
	{ "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
	{
		"andrewferrier/debugprint.nvim",
		config = function()
			require("debugprint").setup()
		end,
	},
	{
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		lazy = true,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},
	{ "tyru/open-browser.vim", lazy = true },
	{
		"Bekaboo/dropbar.nvim",
		-- optional, but required for fuzzy finder support
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		config = function()
			local dropbar_api = require("dropbar.api")
			vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
			vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
			vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
		end,
		opts = {
			icons = {
				ui = {
					bar = {
						separator = "!",
					},
				},
			},
		},
	},
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
			{ "<leader>gy", "<cmd>GitLink<cr>",  mode = { "n", "v" }, desc = "Yank git link" },
			{ "<leader>gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
		},
	},
	---@type LazySpec
	{
		"mikavilpas/yazi.nvim",
		version = "*", -- use the latest stable version
		event = "VeryLazy",
		dependencies = {
			{ "nvim-lua/plenary.nvim", lazy = true },
		},
		keys = {
			{
				"<leader>-",
				mode = { "n", "v" },
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				"<leader>cw",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				"<c-up>",
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
		---@type YaziConfig | {}
		opts = {
			open_for_directories = false,
			keymaps = {
				show_help = "<f1>",
			},
		},
		init = function()
			vim.g.loaded_netrwPlugin = 1
		end,
	},
	"opdavies/toggle-checkbox.nvim",
	"tpope/vim-dadbod",
	{
		"kndndrj/nvim-dbee",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		build = function()
			require("dbee").install()
		end,
		config = function()
			require("dbee").setup {
				sources = {
					require("dbee.sources").EnvSource:new("DBEE_CONNECTIONS"),
				},
			}
		end,
	},
	{
		"folke/snacks.nvim",
		---@type snacks.Config
		opts = {
			terminal = {
				-- terminal config
			},
		},
	},
	{
		"carderne/pi-nvim",
		config = function()
			require("pi-nvim").setup()
		end
	}
}
