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
-- Better window navigation
keymap("n", "<Left>", "<C-w>h", opts)
keymap("n", "<Down>", "<C-w>j", opts)
keymap("n", "<Up>", "<C-w>k", opts)
keymap("n", "<Right>", "<C-w>l", opts)

-- Map alt + s to save
keymap("n", "ß", ":update<CR><ESC>", opts)
keymap("v", "ß", "<C-C>:update<CR><ESC>", opts)
keymap("i", "ß", "<C-O>:update<CR><ESC>", opts)

keymap("n", "<bslash>t", ":bo term<CR>:startinsert<CR>", opts)

-- Vue
keymap("n", "<leader>c", "/script<CR>ggn", opts)
keymap("n", "<leader>v", "/template<CR>ggn", opts)

-- Telescope
keymap("n", "<bslash>f", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<bslash>s", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)

-- nvim-tree
keymap("n", "<C-t>", ":NvimTreeToggle<CR>", opts)

-- bufferline
keymap("n", "tg", ":BufferLinePick<CR>", opts)
keymap("n", "<bslash>w", ":BufferLineCloseLeft<CR>:BufferLineCloseRight<CR>", opts)
keymap("n", "<bslash>q", ":Bdelete<CR>", opts)

-- shift to navigate buffers
keymap("n", "<Tab>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opts)
-- close buffer
keymap("n", "<blash>q", ":bd<CR>", opts)
-- keymap("n", "<blash>w", ":%bd\|e#<CR>", opts)

-- whichkey
keymap("n", "<bslash>a", ":WhichKey<CR>", opts)
