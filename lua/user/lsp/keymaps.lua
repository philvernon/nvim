local keymap = vim.keymap.set

local function map(mode, lhs, rhs, desc)
	keymap(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

map("n", "gD", vim.lsp.buf.declaration, "Declaration")
map("n", "gd", vim.lsp.buf.definition, "Definition")
map("n", "<leader>gi", vim.lsp.buf.implementation, "Implementation")
map("n", "<leader>gl", function()
	vim.diagnostic.open_float({ border = "rounded" })
end, "Diagnostic")
map("n", "<leader>gr", vim.lsp.buf.references, "References")
map("n", "K", function()
	vim.lsp.buf.hover({ border = "none" })
end, "Hover")
map("n", "<leader>gk", vim.lsp.buf.signature_help, "Signature")
map("n", "<leader>gf", function()
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
	})
end, "Format")

map("n", "<leader>dq", vim.diagnostic.toqflist, "Quickfix")
map("n", "<leader>ds", function()
	vim.diagnostic.config({ virtual_text = true })
end, "Show")
map("n", "<leader>dh", function()
	vim.diagnostic.config({ virtual_text = false })
end, "Hide")

map("n", "<leader>dd", "<cmd>lua toggle_diagnostic()<CR>", "Toggle")
map("n", "<leader>de", vim.diagnostic.enable, "Enable")

map({ "n", "v" }, "<leader>gn", vim.lsp.buf.rename, "Rename")
map({ "n", "v" }, "<leader>ga", vim.lsp.buf.code_action, "Actions")

map("n", "]d", function()
	vim.diagnostic.goto_next({ border = "rounded", focusable = true })
end, "Next diagnostic")
map("n", "[d", function()
	vim.diagnostic.goto_prev({ border = "rounded" })
end, "Prev diagnostic")
