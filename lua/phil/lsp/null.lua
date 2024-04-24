local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local nullls = require("null-ls")

nullls.setup({
	sources = {
		nullls.builtins.formatting.prettier,
		nullls.builtins.diagnostics.eslint_d,
		nullls.builtins.code_actions.eslint_d,
		-- nullls.builtins.completion.spell,
		nullls.builtins.formatting.stylua,
	},
	on_attach = function(client, bufnr)
		-- format with language server by default
		if client.name == "sumneko_lua" then
			client.server_capabilities.document_formatting = false
			client.server_capabilities.document_range_formatting = false
		end

		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					-- vim.lsp.buf.formatting_sync()
					vim.lsp.buf.format({
						filter = function(client)
							return client.name == "null-ls"
						end,
						bufnr = bufnr,
					})
				end,
			})
		end
	end,
})
