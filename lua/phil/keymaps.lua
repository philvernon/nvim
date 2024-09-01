local opts = { noremap = true, silent = true }
-- local keymap = vim.api.nvim_set_keymap
local keymap = vim.keymap.set

-- GENERAL
keymap("n", "<leader>qq", ":wqa<CR>", opts)

-- Better window navigation
keymap("n", "<Left>", "<C-w>h", opts)
keymap("n", "<Down>", "<C-w>j", opts)
keymap("n", "<Up>", "<C-w>k", opts)
keymap("n", "<Right>", "<C-w>l", opts)
keymap("n", "<leader>l", ":q<CR>", opts)
-- open split
keymap("n", "<leader>s", ":vsplit<CR>", opts)
keymap("n", "<leader>S", ":split<CR>", opts)
-- buffer
keymap("n", "<blash>q", ":bd<CR>", opts)
keymap("n", "<leader><tab>", ":bn<CR>", opts)
keymap("n", "<leader><s-tab>", ":bp<CR>", opts)
-- quickfix
keymap("n", "]e", ":cnext<CR>", opts)
keymap("n", "[e", ":cprev<CR>", opts)
-- jk to exit insert mode
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)
keymap("i", "jj", "<ESC>", opts)
keymap("i", "kk", "<ESC>", opts)
-- Map alt + s to save
keymap("n", "ß", "<ESC>:update<CR>", opts)
keymap("v", "ß", "<C-C>:update<CR><ESC>", opts)
keymap("i", "ß", "<C-O>:update<CR><ESC>", opts)
-- Map super + s to save on linux
keymap("n", "<D-s>", "<ESC>:update<CR>", opts)
keymap("v", "<D-s>", "<C-C>:update<CR><ESC>", opts)
keymap("i", "<D-s>", "<C-O>:update<CR><ESC>", opts)
-- Map Alt + s to save on linux in tmux (ffs)
keymap("n", "<M-s>", "<ESC>:update<CR>", opts)
keymap("v", "<M-s>", "<C-C>:update<CR><ESC>", opts)
keymap("i", "<M-s>", "<C-O>:update<CR><ESC>", opts)
-- center ctrl d and u
keymap("n", "<C-d>", "<C-d>zz", opts)

keymap("n", "<C-u>", "<C-u>zz", opts)
-- paste over and keep in register
keymap("x", "<leader>p", '"_dP', opts)
-- Update vim config
keymap("n", "<bslash>u", ":so ~/.config/nvim/init.lua<CR>", opts)
-- UTIL
-- Vue
keymap("n", "<leader>c", "/script<CR>ggn", opts)
keymap("n", "<leader>v", "/template<CR>ggn", opts)
-- love2d
keymap("n", "<leader>r", ":AsyncRun -mode=term -rows=6 -listed=0 -scroll=1 -focus=0  love .<CR>", opts)

-- PLUGINS
-- Telescope
keymap("n", "<C-f>", "<cmd>Telescope find_files hidden=true<CR>", opts)
keymap("n", "to", "<cmd>Telescope buffers<CR>", opts)
keymap("n", "<bslash>st", "<cmd>Telescope<CR>", opts)
keymap("n", "<bslash>b", "<cmd>Telescope buffers<CR>", opts)
keymap("n", "<bslash>ss", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<bslash>sf", "<cmd>Telescope git_files<CR>", opts)
keymap("n", "<bslash>sh", "<cmd>Telescope help_tags<CR>", opts)
keymap("n", "<bslash>sg", "<cmd>Telescope git_commits<CR>", opts)
keymap("n", "<bslash>sc", "<cmd>Telescope git_status<CR>", opts)
keymap("n", "<bslash>sd", "<cmd>Telescope diagnostics<CR>", opts)
keymap("n", "<bslash>sp", "<cmd>lua require'telescope'.extensions.project.project{}<CR>", opts)
keymap("n", "<bslash>sr", "<cmd>Telescope resume<CR>", opts)

-- neo-tree
keymap("n", "<C-t>", ":Neotree<CR>", opts)
keymap("n", "<bslash>fs", ":Neotree reveal<CR>", opts)
-- bufferline
keymap("n", "tg", ":BufferLinePick<CR>", opts)
-- keymap("n", "<bslash>w", ":BufferLineCloseLeft<CR>:BufferLineCloseRight<CR>", opts)
keymap("n", "<bslash>w", ":w|%bd|e#|bd#<CR>", opts)
keymap("n", "<bslash>q", ":Bdelete<CR>", opts)
-- keymap("n", "<Tab>", ":BufferLineCycleNext<CR>", opts)
-- keymap("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opts)
-- whichkey
keymap("n", "<bslash>a", ":WhichKey<CR>", opts)
-- toggleterm
keymap("t", "<esc>", [[<C-\><C-n>]], opts)
keymap("t", "jk", [[<C-\><C-n>]], opts)
-- outline
keymap("n", "<bslash>o", ":SymbolsOutline<CR>", opts)
-- tabby
keymap("n", "<bslash>ta", ":$tabnew<CR>", opts)
keymap("n", "<bslash>tc", ":tabclose<CR>", opts)
keymap("n", "<bslash>to", ":tabonly<CR>", opts)
keymap("n", "<bslash>tn", ":tabn<CR>", opts)
keymap("n", "<bslash>tp", ":tabp<CR>", opts)
-- harpoon
-- keymap("n", "<leader>h", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
-- keymap("n", "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<CR>", opts)
-- keymap("n", "<C-c>", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", opts)
-- keymap("n", "<C-n>", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", opts)
-- keymap("n", "<C-e>", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", opts)
-- keymap("n", "<C-b>", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", opts)
-- zen
keymap("n", "<leader>ts", "<cmd>ZenMode<CR>", opts)

-- UUID Gen
keymap("n", "<leader>id", '<cmd>exe ":normal i" . system("uuidgen | tr -d \'\\n\'")<CR>', opts)

-- octo
keymap("n", "<leader>gp", "<cmd>Octo pr list<CR>", opts)
keymap("n", "<leader>gi", "<cmd>Octo issue list<CR>", opts)
keymap("n", "<leader>gv", "<cmd>Octo issue list assignee=philvernon<CR>", opts)

-- git
keymap("n", "<leader>gd", "<cmd>Gitsigns diffthis<CR>", opts)
keymap("n", "<leader>gD", "<cmd>Gitsigns diffthis develop<CR>", opts)
keymap("n", "<leader>gs", ":Gitsigns show ", opts)
keymap("n", "<leader>gS", "<cmd>Gitsigns show develop<CR>", opts)
keymap("n", "<bslash>gg", "<cmd>Neogit kind=vsplit<CR>", opts)
keymap("n", "<bslash>gs", "<cmd>Gitsigns stage_buffer<CR>", opts)
keymap("n", "<bslash>gh", "<cmd>Gitsigns stage_hunk<CR>", opts)

-- session
keymap("n", "<bslash>c", "<cmd>SessionRestore<CR>", opts)

-- translate
keymap("n", "<bslash>l", "<cmd>Translate<CR>", opts)
