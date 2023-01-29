local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Remap comma as leader key
keymap("", ",", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- GENERAL
-- Better window navigation
keymap("n", "<Left>", "<C-w>h", opts)
keymap("n", "<Down>", "<C-w>j", opts)
keymap("n", "<Up>", "<C-w>k", opts)
keymap("n", "<Right>", "<C-w>l", opts)

keymap("n", "<leader>s", ":vsplit<CR>", opts)

-- close buffer
keymap("n", "<blash>q", ":bd<CR>", opts)

-- jk to exit insert mode
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)
keymap("i", "jj", "<ESC>", opts)
keymap("i", "kk", "<ESC>", opts)

-- Map alt + s to save
keymap("n", "ß", "<ESC>:update<CR>", opts)
keymap("v", "ß", "<C-C>:update<CR><ESC>", opts)
keymap("i", "ß", "<C-O>:update<CR><ESC>", opts)

-- center ctrl d and u
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- paste over and keep in register
keymap("x", "<leader>p", "\"_dP", opts)

-- keymap("n", "<C-Tab>", "<C-I>", opts)
keymap("n", "<tab>", "<c-n>", opts)

-- Update vim config
keymap("n", "<bslash>u", ":so ~/.config/nvim/init.lua<CR>", opts)

-- Vue
keymap("n", "<leader>c", "/script<CR>ggn", opts)
keymap("n", "<leader>v", "/template<CR>ggn", opts)

-- Telescope
keymap("n", "<C-f>", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<bslash>st", "<cmd>Telescope<CR>", opts)
keymap("n", "<bslash>b", "<cmd>Telescope buffers<CR>", opts)
keymap("n", "<bslash>ss", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<bslash>sf", "<cmd>Telescope git_files<CR>", opts)
keymap("n", "<bslash>sb", "<cmd>Telescope buffers<CR>", opts)
keymap("n", "<bslash>sh", "<cmd>Telescope help_tags<CR>", opts)
keymap("n", "<bslash>sg", "<cmd>Telescope git_commits<CR>", opts)
keymap("n", "<bslash>sc", "<cmd>Telescope git_status<CR>", opts)

-- nvim-tree
-- keymap("n", "<C-t>", ":NvimTreeToggle<CR>", opts)
-- keymap("n", "<leader>tt", ":NvimTreeFocus<CR>", opts)
-- keymap("n", "<leader>tf", ":NvimTreeFindFile<CR>", opts)

-- neo-tree
keymap("n", "<C-t>", ":Neotree<CR>", opts)
-- keymap("n", "<Tab>", ":Neotree buffers top<CR>", opts)

-- keymap("n", "<leader>tt", ":NvimTreeFocus<CR>", opts)
keymap("n", "<leader>tf", ":Neotree reveal<CR>", opts)

-- bufferline
keymap("n", "tg", ":BufferLinePick<CR>", opts)
-- keymap("n", "<bslash>w", ":BufferLineCloseLeft<CR>:BufferLineCloseRight<CR>", opts)
keymap("n", "<bslash>w", ":w|%bd|e#|bd#<CR>", opts)
keymap("n", "<bslash>q", ":Bdelete<CR>", opts)

-- shift to navigate buffers
keymap("n", "<Tab>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opts)
-- keymap("n", "<blash>w", ":%bd\|e#<CR>", opts)

-- whichkey
keymap("n", "<bslash>a", ":WhichKey<CR>", opts)

-- toggleterm
-- keymap('n', "<C-bslash>", ":ToggleTerm<CR>", opts)
keymap('t', '<esc>', [[<C-\><C-n>]], opts)
keymap('t', 'jk', [[<C-\><C-n>]], opts)
-- keymap('t', '<esc>', [[<C-\><C-n> <C-w>k]], opts)
-- keymap('t', '<C-bslash>', [[<C-\><C-n> <cmd>FloatermToggle<CR>]], opts)
-- keymap('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
-- keymap('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
-- keymap('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)

-- outline
keymap('n', '<bslash>o', ":SymbolsOutline<CR>", opts)

-- love2d
keymap('n', '<leader>r', ":AsyncRun -mode=term -rows=6 -listed=0 -scroll=1 -focus=0  love .<CR>", opts)

-- tabby
keymap("n", "<bslash>ta", ":$tabnew<CR>", opts)
keymap("n", "<bslash>tc", ":tabclose<CR>", opts)
keymap("n", "<bslash>to", ":tabonly<CR>", opts)
keymap("n", "<bslash>tn", ":tabn<CR>", opts)
keymap("n", "<bslash>tp", ":tabp<CR>", opts)
