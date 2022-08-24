vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha

require("catppuccin").setup()

vim.cmd [[
try
colorscheme kanagawa
catch /^Vim\%((\a\+)\)\=:E185/
colorscheme default
set background=dark
endtry

]]

