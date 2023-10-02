local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "<bslash>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "<bslash>gl", '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>', opts)
keymap('n', '<bslash>gr', "<cmd>lua vim.lsp.buf.references()<CR>", opts)
keymap('n', 'K', "<cmd>lua vim.lsp.buf.hover({border = 'rounded' })<CR>", opts)
keymap('n', '<bslash>k', "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
keymap('n', '<bslash>gf', "<cmd>lua vim.lsp.buf.format({filter = function(client) return client.name == 'null-ls' end})<CR>", opts)
-- keymap('n', '<bslash>gf',
-- function()
--   vim.lsp.buf.format({filter = function(client)
--     return client.name == 'null-ls'
--   end
-- }),
-- end,
-- opts)


keymap('n', '<leader>dq', "<cmd>lua vim.diagnostic.toqflist()<CR>", opts)
-- keymap('n', '<leader>ds', "<cmd>lua vim.diagnostic.show()<CR>", opts)
-- keymap('n', '<leader>dh', "<cmd>lua vim.diagnostic.hide()<CR>", opts)
keymap('n', '<leader>ds', "<cmd>:lua vim.diagnostic.config({ virtual_text = true })<CR>", opts)
keymap('n', '<leader>dh', "<cmd>:lua vim.diagnostic.config({ virtual_text = false })<CR>", opts)

function toggle_diagnostic()
  if vim.diagnostic.is_disabled() then
    vim.diagnostic.enable()
  else
    vim.diagnostic.disable()
  end
end

keymap('n', '<leader>dd', "<cmd>lua toggle_diagnostic()<CR>", opts)
keymap('n', '<leader>de', "<cmd>lua vim.diagnostic.enable()<CR>", opts)

keymap('n', '<bslash>gn', "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
keymap('n', '<bslash>ga', "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

keymap("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
keymap("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
