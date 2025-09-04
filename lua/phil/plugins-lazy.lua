local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local config = {
	defaults = {
		-- lazy = true
	},
}

require("lazy").setup({
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
	},
	"JoosepAlviste/nvim-ts-context-commentstring",
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			{
				-- only needed if you want to use the commands with "_with_window_picker" suffix
				"s1n7ax/nvim-window-picker",
				version = "1.*",
				config = function()
					require("window-picker").setup({
						autoselect_one = true,
						include_current = false,
						filter_rules = {
							-- filter using buffer options
							bo = {
								-- if the file type is one of following, the window will be ignored
								filetype = { "neo-tree", "neo-tree-popup", "notify" },

								-- if the buffer type is one of following, the window will be ignored
								buftype = { "terminal", "quickfix" },
							},
						},
						other_win_hl_color = "#e35e4f",
					})
				end,
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		-- tag = "0.1.0",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"pwntester/octo.nvim",
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

	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",

	{ "neovim/nvim-lspconfig" },
	-- "simrat39/rust-tools.nvim",
	-- "rust-lang/rust.vim",
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
	{ "nvimtools/none-ls.nvim", dependencies = { "nvim-lua/plenary.nvim", "nvimtools/none-ls-extras.nvim" } },
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
	{ "windwp/nvim-autopairs" },
	-- { 'echasnovski/mini.pairs', version = '*' },
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-nvim-lsp-signature-help",
	"hrsh7th/cmp-calc",
	"hrsh7th/nvim-cmp",
	-- "ms-jpq/coq_nvim",
	"rafamadriz/friendly-snippets",
	"L3MON4D3/LuaSnip",
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
	"kylechui/nvim-surround",
	-- "roycrippen4/nvim-ts-autotag",
	"windwp/nvim-ts-autotag",
	{ "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },
	"famiu/bufdelete.nvim",
	"lukas-reineke/indent-blankline.nvim",
	"lewis6991/gitsigns.nvim",
	"numToStr/Comment.nvim",
	{ "folke/which-key.nvim" },
	"akinsho/toggleterm.nvim",
	{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons", opt = true } },
	{ "catppuccin/nvim", as = "catppuccin", priority = 1000 },
	"hedyhli/outline.nvim",
	"rmagatti/auto-session",
	"norcalli/nvim-colorizer.lua",
	"dkarter/bullets.vim",
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
	{ "weirongxu/plantuml-previewer.vim", lazy = true },
	-- { "iamcco/markdown-preview.nvim" },
	{
		"toppair/peek.nvim",
		event = { "VeryLazy" },
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup()
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		end,
	},
	{ "mfussenegger/nvim-dap", lazy = true },
	{ "jay-babu/mason-nvim-dap.nvim" },
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		lazy = true,
	},
	{ "ellisonleao/glow.nvim" },
	{ "skywind3000/asyncrun.vim" },
	{ "tyru/open-browser.vim", lazy = true },
	{
		"glacambre/firenvim",
		run = function()
			vim.fn["firenvim#install"](0)
		end,
		lazy = true,
	},
	"folke/zen-mode.nvim",
	{
		"OXY2DEV/markview.nvim",
		lazy = false,

		-- For `nvim-treesitter` users.
		priority = 49,

		-- For blink.cmp's completion
		-- source
		-- dependencies = {
		--     "saghen/blink.cmp"
		-- },
	},
	-- {
	-- 	"MeanderingProgrammer/render-markdown.nvim",
	-- 	opts = {},
	-- 	config = function()
	-- 		require("render-markdown").setup({
	-- 			heading = {
	-- 				width = "block",
	-- 				above = "|||",
	-- 				icons = { "§ ", "§§ ", "§§§ ", "§§§§ ", "§§§§§ " },
	-- 			},
	-- 		})
	-- 	end,
	-- 	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
	-- },
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
			{ "<leader>gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank git link" },
			{ "<leader>gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
		},
	},
	"github/copilot.vim",
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		-- build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			-- 		-- See Configuration section for options
		},
		-- 	-- See Commands section for default commands if you want to lazy load on them
	},
	{ import = "phil.plugins" },
	-- {
	--   "nvim-neorg/neorg",
	--   build = ":Neorg sync-parsers",
	--   dependencies = { "nvim-lua/plenary.nvim" },
	--   config = function()
	--     require("neorg").setup {
	--       load = {
	--         ["core.defaults"] = {}, -- Loads default behaviour
	--         ["core.concealer"] = {}, -- Adds pretty icons to your documents
	--         ["core.dirman"] = { -- Manages Neorg workspaces
	--           config = {
	--             workspaces = {
	--               notes = "~/notes",
	--             },
	--           },
	--         },
	--       },
	--     }
	--   end,
	-- },
}, config)
