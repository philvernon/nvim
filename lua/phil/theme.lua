-- vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

require("catppuccin").setup({
	flavour = "mocha",
	integrations = {
		-- treesitter_context = true,
		-- treesitter = true,
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			},
		},
		-- 	lsp_trouble = true,
		cmp = true,
		gitsigns = true,
		telescope = true,
		nvimtree = {
			enabled = true,
			show_root = false,
			transparent_panel = false,
		},
		-- 	dropbar = true,
		-- 	hlchunk = true,
		mason = true,
		-- 	noice = true,
		-- 	barbar = true,
	},
})

-- vim.cmd [[
-- try
-- colorscheme kanagawa
-- catch /^Vim\%((\a\+)\)\=:E185/
-- colorscheme default
-- set background=dark
-- endtry
-- ]]
--
vim.cmd("colorscheme catppuccin")
