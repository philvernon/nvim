vim.g.coq_settings = {
	auto_start = "shut-up",
	clients = {
		snippets = {
			enabled = true,
			weight_adjust = 2,
		},
		lsp = {
			enabled = true,
			resolve_timeout = 2,
			weight_adjust = 1.75,
		},
		tree_sitter = {
			enabled = true,
			weight_adjust = 1.5,
		},
	},
}

vim.cmd([[COQnow --shut-up]])
