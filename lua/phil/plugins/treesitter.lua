require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"javascript",
		"css",
		"html",
		"scss",
		"vue",
		"typescript",
		"json",
		"bash",
		"lua",
		"vim",
		"vimdoc",
	},
	highlight = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			-- init_selection = "<CR>",
			-- scope_incremental = "<CR>",
			-- node_incremental = "<TAB>",
			-- node_decremental = "<S-TAB>",
		},
	},
	autotag = {
		enable = true,
		filetypes = {
			"html",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"svelte",
			"vue",
			"markdown",
			"scss",
			"css",
		},
	},
})

require("ts_context_commentstring").setup({
	enable_autocmd = false,
})

vim.g.skip_ts_context_commentstring_module = true
