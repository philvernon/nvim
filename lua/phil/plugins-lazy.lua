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
	-- "windwp/nvim-ts-autotag",
	{ "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },
	"famiu/bufdelete.nvim",
	"lukas-reineke/indent-blankline.nvim",
	"lewis6991/gitsigns.nvim",
	"numToStr/Comment.nvim",
	{ "folke/which-key.nvim" },
	"akinsho/toggleterm.nvim",
	{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons", opt = true } },
	{ "catppuccin/nvim",           as = "catppuccin",                                           priority = 1000 },
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
	{ "mfussenegger/nvim-dap",       lazy = true },
	{ "jay-babu/mason-nvim-dap.nvim" },
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		lazy = true,
	},
	{
		'MeanderingProgrammer/render-markdown.nvim',
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},
	{ "skywind3000/asyncrun.vim" },
	{ "tyru/open-browser.vim",   lazy = true },
	{
		"glacambre/firenvim",
		run = function()
			vim.fn["firenvim#install"](0)
		end,
		lazy = true,
	},
	"folke/zen-mode.nvim",
	-- {
	-- 	"OXY2DEV/markview.nvim",
	-- 	lazy = false,
	--
	-- 	-- For `nvim-treesitter` users.
	-- 	priority = 49,
	--
	-- 	-- For blink.cmp's completion
	-- 	-- source
	-- 	-- dependencies = {
	-- 	--     "saghen/blink.cmp"
	-- 	-- },
	-- },
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
			{ "<leader>gy", "<cmd>GitLink<cr>",  mode = { "n", "v" }, desc = "Yank git link" },
			{ "<leader>gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
		},
	},
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_enabled = false
		end
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "github/copilot.vim" },                    -- or zbirenbaum/copilot.lua
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		-- build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			-- 		-- See Configuration section for options
		},
		-- 	-- See Commands section for default commands if you want to lazy load on them
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
			-- 👇 in this section, choose your own keymappings!
			{
				"<leader>-",
				mode = { "n", "v" },
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				-- Open in the current working directory
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
			-- if you want to open yazi instead of netrw, see below for more info
			open_for_directories = false,
			keymaps = {
				show_help = "<f1>",
			},
		},
		-- 👇 if you use `open_for_directories=true`, this is recommended
		init = function()
			-- mark netrw as loaded so it's not loaded at all.
			--
			-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
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
			-- Install tries to automatically detect the install method.
			-- if it fails, try calling it with one of these parameters:
			--    "curl", "wget", "bitsadmin", "go"
			require("dbee").install()
		end,
		config = function()
			require("dbee").setup {
				sources = {
					require("dbee.sources").EnvSource:new("DBEE_CONNECTIONS")
				}
			}
		end,
	},
	-- lazy.nvim
	{
		"folke/snacks.nvim",
		---@type snacks.Config
		opts = {
			terminal = {
				-- your terminal configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		}
	},
	-- {
	-- 	"nickjvandyke/opencode.nvim",
	-- 	version = "*", -- Latest stable release
	-- 	dependencies = {
	-- 		{
	-- 			-- `snacks.nvim` integration is recommended, but optional
	-- 			---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
	-- 			"folke/snacks.nvim",
	-- 			opts = {
	-- 				input = {}, -- Enhances `ask()`
	-- 				picker = { -- Enhances `select()`
	-- 					actions = {
	-- 						-- opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
	-- 					},
	-- 					win = {
	-- 						input = {
	-- 							keys = {
	-- 								-- ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
	-- 							},
	-- 						},
	-- 					},
	-- 				},
	-- 			},
	-- 		},
	-- 		{
	-- 			"e-cal/opencode-tmux.nvim",
	-- 			opts = {
	-- 				options = "-h",
	-- 				focus = false,
	-- 				auto_close = false,
	-- 				allow_passthrough = false,
	-- 				find_sibling = true,
	-- 			},
	-- 		},
	-- 	},
	-- 	config = function()
	-- 		vim.o.autoread = true -- Required for `opts.events.reload`
	-- 		-- Recommended/example keymaps
	-- 		vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end,
	-- 			{ desc = "Ask opencode…" })
	-- 		vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,
	-- 			{ desc = "Execute opencode action…" })
	-- 		vim.keymap.set({ "n", "t" }, "<C-p>", function() require("opencode").toggle() end, { desc = "Toggle opencode" })
	--
	-- 		vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end,
	-- 			{ desc = "Add range to opencode", expr = true })
	-- 		vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end,
	-- 			{ desc = "Add line to opencode", expr = true })
	--
	-- 		vim.keymap.set("n", "<S-u>", function() require("opencode").command("session.half.page.up") end,
	-- 			{ desc = "Scroll opencode up" })
	-- 		vim.keymap.set("n", "<S-d>", function() require("opencode").command("session.half.page.down") end,
	-- 			{ desc = "Scroll opencode down" })
	--
	-- 		-- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
	-- 		vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
	-- 		vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
	-- 	end,
	-- },
	{
		"sudo-tee/opencode.nvim",
		config = function()
			require("opencode").setup({
				keymap = {
					editor = {
						['<C-p>'] = { 'toggle' }, -- Open opencode. Close if opened
					}
				}
			})
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					anti_conceal = { enabled = false },
					file_types = { 'markdown', 'opencode_output' },
				},
				ft = { 'markdown', 'Avante', 'copilot-chat', 'opencode_output' },
			},
			-- Optional, for file mentions and commands completion, pick only one
			-- 'saghen/blink.cmp',
			-- 'hrsh7th/nvim-cmp',

			-- Optional, for file mentions picker, pick only one
			'folke/snacks.nvim',
			-- 'nvim-telescope/telescope.nvim',
			-- 'ibhagwan/fzf-lua',
			-- 'nvim_mini/mini.nvim',
		},
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
