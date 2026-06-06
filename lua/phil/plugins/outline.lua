return {
	"jose-elias-alvarez/null-ls.nvim",
	event = "VeryLazy",
	config = function()
		require("outline").setup({})
	end,
}
