return {
	"davidgranstrom/scnvim",
	{
		"j-hui/fidget.nvim",
		opts = {
			-- options
		},
	},
	"nvim-lua/plenary.nvim",
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
	},
	"JoosepAlviste/nvim-ts-context-commentstring",
	{
		"nvim-neo-tree/neo-tree.nvim",
		lazy = false,
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		lazy = false,
		-- tag = "0.1.0",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"pwntester/octo.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-tree/nvim-web-devicons",
		},
	},
	"benfowler/telescope-luasnip.nvim",
	"nvim-telescope/telescope-project.nvim",
	-- "williamboman/nvim-lsp-installer",
	{
		"folke/trouble.nvim",
		lazy = false,
		opts = {},
		cmd = "Trouble",
	},
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

	{ "williamboman/mason.nvim",           lazy = false },
	{ "williamboman/mason-lspconfig.nvim", lazy = false },

	{ "neovim/nvim-lspconfig",             lazy = false },
	-- "simrat39/rust-tools.nvim",
	-- "rust-lang/rust.vim",
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
	{ "nvimtools/none-ls.nvim",                 dependencies = { "nvim-lua/plenary.nvim", "nvimtools/none-ls-extras.nvim" } },
	{ "nvim-telescope/telescope-ui-select.nvim" },
	-- { "stevearc/conform.nvim" },
	{ "mfussenegger/nvim-lint" },
	{
		"folke/neodev.nvim",
		opts = {},
		config = function()
			require("neodev").setup()
		end,
	},
	{ "windwp/nvim-autopairs", lazy = false },
	-- { 'echasnovski/mini.pairs', version = '*' },
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-nvim-lsp-signature-help",
	"hrsh7th/cmp-calc",
	{ "hrsh7th/nvim-cmp",      lazy = false },
	-- "ms-jpq/coq_nvim",
	"rafamadriz/friendly-snippets",
	{ "L3MON4D3/LuaSnip",       lazy = false },
	"saadparwaiz1/cmp_luasnip",
	-- "fatih/vim-go",
	-- {
	-- 	"ray-x/go.nvim",
	-- 	dependencies = { -- optional packages
	-- 		"ray-x/guihua.lua",
	-- 		"neovim/nvim-lspconfig",
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 	},
	-- 	config = function()
	-- 		require("go").setup()
	-- 	end,
	-- 	event = { "CmdlineEnter" },
	-- 	ft = { "go", "gomod" },
	-- 	build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	-- },
	{ "kylechui/nvim-surround", lazy = false },
	-- "roycrippen4/nvim-ts-autotag",
	-- "windwp/nvim-ts-autotag",
	{ "kevinhwang91/nvim-ufo",  dependencies = "kevinhwang91/promise-async" },
	"famiu/bufdelete.nvim",
	"lukas-reineke/indent-blankline.nvim",
	{ "lewis6991/gitsigns.nvim",   lazy = false },
	{ "numToStr/Comment.nvim",     lazy = false },
	{ "folke/which-key.nvim",      lazy = false },
	{ "akinsho/toggleterm.nvim",   lazy = false },
	{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons", opt = true } },
	{ "catppuccin/nvim",           name = "catppuccin",                                         priority = 1000 },
	{ "hedyhli/outline.nvim",      lazy = false },
	"norcalli/nvim-colorizer.lua",
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
	{ "sindrets/diffview.nvim",      dependencies = "nvim-lua/plenary.nvim" },
	{
		"andrewferrier/debugprint.nvim",
		config = function()
			require("debugprint").setup()
		end,
	},
	-- { "weirongxu/plantuml-previewer.vim", lazy = true },
	-- { "iamcco/markdown-preview.nvim" },
	-- {
	-- 	"toppair/peek.nvim",
	-- 	event = { "VeryLazy" },
	-- 	build = "deno task --quiet build:fast",
	-- 	config = function()
	-- 		require("peek").setup()
	-- 		vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
	-- 		vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
	-- 	end,
	-- },
	{ "mfussenegger/nvim-dap",       lazy = false },
	{ "jay-babu/mason-nvim-dap.nvim" },
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		lazy = true,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},
	{ "tyru/open-browser.vim",   lazy = true },
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
	-- {
	-- 	"alex35mil/pi.nvim",
	-- 	dependencies = { "HakonHarnes/img-clip.nvim" },
	-- 	config = true
	-- }
	-- {
	-- 	"pablopunk/pi.nvim",
	-- 	config = function()
	-- 		require("pi").setup()
	-- 	end,
	-- },
}
