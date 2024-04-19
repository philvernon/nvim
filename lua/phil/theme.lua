-- vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

require("catppuccin").setup({
  flavour = "mocha"
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
