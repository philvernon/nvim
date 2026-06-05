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
		config = function()
			require("phil.plugins.treesitter")
		end,
	},
	"JoosepAlviste/nvim-ts-context-commentstring",
	{
		"nvim-neo-tree/neo-tree.nvim",
		lazy = false,
		config = function()
			require("phil.plugins.neo-tree")
		end,
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
		lazy = false,
		config = function()
			require("phil.plugins.telescope")
		end,
		-- tag = "0.1.0",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"pwntester/octo.nvim",
		lazy = false,
		config = function()
			require("phil.plugins.octo")
		end,
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
		config = function()
			require("phil.plugins.trouble")
		end,
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

	{ "williamboman/mason.nvim", lazy = false, config = function() require("phil.plugins.mason") end },
	{ "williamboman/mason-lspconfig.nvim", lazy = false, config = function() require("phil.plugins.lsp.lsp-mason") end },

	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			require("phil.plugins.lsp.config")
			require("phil.plugins.lsp.vue")
			require("phil.plugins.lsp.rust")
			require("phil.plugins.lsp.keymaps")
		end,
	},
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
	{ "windwp/nvim-autopairs", lazy = false, config = function() require("phil.plugins.autopairs") end },
	-- { 'echasnovski/mini.pairs', version = '*' },
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-nvim-lsp-signature-help",
	"hrsh7th/cmp-calc",
	{ "hrsh7th/nvim-cmp", lazy = false, config = function() require("phil.plugins.nvim-cmp") end },
	-- "ms-jpq/coq_nvim",
	"rafamadriz/friendly-snippets",
	{ "L3MON4D3/LuaSnip", lazy = false, config = function() require("phil.plugins.luasnip") end },
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
	{ "kylechui/nvim-surround", lazy = false, config = function() require("phil.plugins.surround") end },
	-- "roycrippen4/nvim-ts-autotag",
	-- "windwp/nvim-ts-autotag",
	{ "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async", config = function() require("phil.plugins.fold") end },
	"famiu/bufdelete.nvim",
	"lukas-reineke/indent-blankline.nvim",
	{ "lewis6991/gitsigns.nvim", lazy = false, config = function() require("phil.plugins.gitsigns") end },
	{ "numToStr/Comment.nvim", lazy = false, config = function() require("phil.plugins.comment") end },
	{ "folke/which-key.nvim", lazy = false, config = function() require("phil.plugins.whichkey") end },
	{ "akinsho/toggleterm.nvim", lazy = false, config = function() require("phil.plugins.toggleterm") end },
	{ "nvim-lualine/lualine.nvim", lazy = false, config = function() require("phil.plugins.lualine") end, dependencies = { "nvim-tree/nvim-web-devicons", opt = true } },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "hedyhli/outline.nvim", lazy = false, config = function() require("phil.plugins.outline") end },
	{ "rmagatti/auto-session", lazy = false, config = function() require("phil.plugins.session") end },
	{ "norcalli/nvim-colorizer.lua", config = function() require("phil.plugins.colorizor") end },
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
	{ "mfussenegger/nvim-dap", lazy = false, config = function() require("phil.plugins.dap") end },
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
	{ "skywind3000/asyncrun.vim" },
	{ "tyru/open-browser.vim", lazy = true },
	{
		"glacambre/firenvim",
		build = function()
			vim.fn["firenvim#install"](0)
		end,
		lazy = true,
	},
	{ "folke/zen-mode.nvim", lazy = false, config = function() require("phil.plugins.zen") end },
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
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_enabled = false
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		-- build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			-- See Configuration section for options
		},
		-- See Commands section for default commands if you want to lazy load on them
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
		"sudo-tee/opencode.nvim",
		config = function()
			require("opencode").setup({
				keymap = {
					editor = {
						["<C-p>"] = { "toggle" },
					},
				},
			})
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					anti_conceal = { enabled = false },
					file_types = { "markdown", "opencode_output" },
				},
				ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
			},
			"folke/snacks.nvim",
		},
	},
	{
		"pablopunk/pi.nvim",
		config = function()
			require("pi").setup()
		end,
	},
}
