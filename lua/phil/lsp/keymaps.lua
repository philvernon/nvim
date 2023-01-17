local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "<bslash>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "<bslash>gl", '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>', opts)
keymap('n', '<bslash>gr', "<cmd>lua vim.lsp.buf.references()<CR>", opts)
keymap('n', 'K', "<cmd>lua vim.lsp.buf.hover({border = 'rounded' })<CR>", opts)

keymap('n', '<bslash>gn', "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
keymap('n', '<bslash>ga', "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

keymap("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
keymap("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
