local options = {
    backup = false,
    writebackup = false,
    colorscheme = nightfox,
    termguicolors = true,
    number = true,
    relativenumber = false,
    hlsearch = false,
    ignorecase = false,
    showtabline = 2,
    splitbelow = true,
    splitright = true,
    undofile = true,
    updatetime = 300,
    cursorline = true,
    showcmd = true,
    signcolumn = "yes",
    scrolloff = 8,
    incsearch = true,
    colorcolumn = "80",
    softtabstop = 4,
    shiftwidth = 4,
    hidden = true,
    cmdheight = 2,
    fileencoding = "utf-8",
    expandtab = true, -- convert tabs to spaces
    tabstop = 2, -- insert 2 spaces for a tab
    spelllang = en,
}

vim.cmd([[
try
highlight SignColumn guibg=None
highlight WinSeperator guibg=None
]])

-- vim.g.colors_name = "angr"

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
    vim.opt[k] = v
end
