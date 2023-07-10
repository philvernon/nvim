local options = {
    backup = false,
    writebackup = false,
    termguicolors = true,
    number = true,
    relativenumber = true,
    hlsearch = false,
    ignorecase = true,
    showtabline = 1,
    splitbelow = true,
    splitright = true,
    undofile = true,
    updatetime = 100,
    timeoutlen = 500,
    cursorline = true,
    showcmd = true,
    signcolumn = "yes",
    scrolloff = 8,
    incsearch = true,
    colorcolumn = "80",
    -- softtabstop = 4,
    shiftwidth = 2,
    hidden = true,
    -- cmdheight = 2,
    fileencoding = "utf-8",
    expandtab = true, -- convert tabs to spaces
    tabstop = 2, -- insert 2 spaces for a tab
    clipboard = "unnamedplus",
    mouse = "a",
    laststatus = 3,
}

-- let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
-- let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

vim.cmd([[
try
highlight SignColumn guibg=None
highlight WinSeperator guibg=None
]])

-- vim.g.colors_name = "angr"

vim.opt.shortmess:append("c")
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0

for k, v in pairs(options) do
  vim.opt[k] = v
end
