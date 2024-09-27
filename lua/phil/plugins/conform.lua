return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "isort", "black" },
				-- Use a sub-list to run only the first available formatter
				javascript = { "prettierd", "prettier" },
				vue = { "prettierd", "prettier" },
				scss = { "prettierd", "prettier" },
				typescript = { "prettierd", "prettier" },
				rust = { "rustfmt" },
			},
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				-- format with conform and store response
				local didConformFormat = require("conform").format({ bufnr = args.buf, quiet = true })

				-- If conform format was unsuccessful use LSP format
				if didConformFormat == false then
					local buf_clients = vim.lsp.get_clients()

					-- Check LSP clients that support formatting
					for _, client in pairs(buf_clients) do
						if client.supports_method("textDocument/formatting") then
							-- vim.lsp.buf.format({ async = true })
						end
					end
				end
			end,
		})
	end,
}
