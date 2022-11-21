local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
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

-- Update vim config
keymap("n", "<bslash>u", ":so ~/.config/nvim/init.lua<CR>", opts)

-- Vue
keymap("n", "<leader>c", "/script<CR>ggn", opts)
keymap("n", "<leader>v", "/template<CR>ggn", opts)

-- Telescope
keymap("n", "<bslash>f", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<bslash>ss", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<bslash>sf", "<cmd>Telescope git_files<CR>", opts)
keymap("n", "<bslash>sb", "<cmd>Telescope buffers<CR>", opts)
keymap("n", "<bslash>sh", "<cmd>Telescope help_tags<CR>", opts)
keymap("n", "<bslash>sg", "<cmd>Telescope git_commits<CR>", opts)
keymap("n", "<bslash>sc", "<cmd>Telescope git_status<CR>", opts)

-- nvim-tree
keymap("n", "<C-t>", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>tt", ":NvimTreeFocus<CR>", opts)
keymap("n", "<leader>tf", ":NvimTreeFindFile<CR>", opts)

-- bufferline
keymap("n", "tg", ":BufferLinePick<CR>", opts)
keymap("n", "<bslash>w", ":BufferLineCloseLeft<CR>:BufferLineCloseRight<CR>", opts)
keymap("n", "<bslash>q", ":Bdelete<CR>", opts)

-- shift to navigate buffers
keymap("n", "<Tab>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opts)
-- keymap("n", "<blash>w", ":%bd\|e#<CR>", opts)

-- whichkey
keymap("n", "<bslash>a", ":WhichKey<CR>", opts)

-- floatterm
keymap('n', "<C-bslash>", ":FloatermToggle<CR>", opts)
keymap('n', "<bslash>t", ":FloatermNew --height=0.6 --width=0.4 --wintype=float --name=floaterm1 --position=topright --autoclose=2 ranger <CR>", opts)

keymap('t', "<C-n>", [[<C-\><C-n> <cmd>FloatermUpdate --height=0.6 --width=0.4 --name=floaterm_name --wintype=float --position=topright:FloatermUpdate --height=0.6 --width=0.4 --name=floaterm_name --wintype=float --position=topright<CR>]], opts)
-- keymap('t', '<esc>', [[<C-\><C-n>]], opts)
-- keymap('t', '<C-bslash>', [[<C-n>]], opts)

-- toggleterm
-- keymap('t', '<esc>', [[<C-\><C-n>]], opts)
keymap('t', '<C-bslash>', [[<C-\><C-n> <cmd>FloatermToggle<CR>]], opts)
-- keymap('t', 'jk', [[<C-\><C-n>]], opts)
keymap('t', '<esc>', [[<C-\><C-n> <C-w>k]], opts)
keymap('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
keymap('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
keymap('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)

-- outline
keymap('n', '<bslash>o', ":SymbolsOutline<CR>", opts)

-- love2d
keymap('n', '<leader>r', ":AsyncRun -mode=term -rows=6 -listed=0 -scroll=1 -focus=0  love .<CR>", opts)
