return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreview", "MarkdownPreviewToggle", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = function() vim.fn["mkdp#util#install"]() end,
	config = function()
		vim.g.mkdp_browser = "firefoxdeveloperedition"
		vim.g.mkdp_theme = "dark"
	end,
}
