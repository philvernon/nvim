return {
	"nvimtools/none-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.completion.gomodifytags,
				null_ls.builtins.completion.impl,
			},
			on_attach = function(current_bufnr)
				local lsp_config = vim.lsp.get_active_clients()[1]

				if lsp_config and lsp_config.name == "sumneko_lua" then
					vim.api.nvim_del_augroup_by_name("null-ls-formatting-on-write")
				end
			end,
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			group = vim.api.nvim_create_augroup("null-ls-formatting-on-write", { clear = true }),
			callback = function()
				local lsp_config = vim.lsp.get_active_clients()[1]

				if lsp_config and lsp_config.name == "sumneko_lua" then
					return
				end

				vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
			end,
		})
	end,
}
