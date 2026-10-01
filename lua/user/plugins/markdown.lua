local function apply_markdown_highlights()
	local colors = require("catppuccin.palettes").get_palette()

	local highlights = {
		RenderMarkdownH1 = { fg = colors.text, bold = true },
		RenderMarkdownH2 = { fg = colors.text, bold = true },
		RenderMarkdownH3 = { fg = colors.text, bold = true },
		RenderMarkdownH4 = { fg = colors.text, bold = true },
		RenderMarkdownH5 = { fg = colors.text, bold = true },
		RenderMarkdownH6 = { fg = colors.text, bold = true },
		RenderMarkdownH1Bg = { bg = colors.none },
		RenderMarkdownH2Bg = { bg = colors.none },
		RenderMarkdownH3Bg = { bg = colors.none },
		RenderMarkdownH4Bg = { bg = colors.none },
		RenderMarkdownH5Bg = { bg = colors.none },
		RenderMarkdownH6Bg = { bg = colors.none },
		RenderMarkdownCode = { bg = colors.mantle },
		RenderMarkdownCodeInfo = { fg = colors.overlay1, bg = colors.mantle },
		RenderMarkdownCodeBorder = { fg = colors.surface0, bg = colors.mantle },
		RenderMarkdownCodeFallback = { fg = colors.overlay1 },
		RenderMarkdownCodeInline = { fg = colors.text, bg = colors.surface0 },
		RenderMarkdownDash = { fg = colors.surface1 },
		RenderMarkdownBullet = { fg = colors.overlay1 },
		RenderMarkdownChecked = { fg = colors.overlay1 },
		RenderMarkdownUnchecked = { fg = colors.overlay1 },
		RenderMarkdownTodo = { fg = colors.overlay1 },
		RenderMarkdownQuote = { fg = colors.overlay1 },
		RenderMarkdownQuote1 = { fg = colors.overlay1 },
		RenderMarkdownQuote2 = { fg = colors.overlay1 },
		RenderMarkdownQuote3 = { fg = colors.overlay1 },
		RenderMarkdownQuote4 = { fg = colors.overlay1 },
		RenderMarkdownQuote5 = { fg = colors.overlay1 },
		RenderMarkdownQuote6 = { fg = colors.overlay1 },
		RenderMarkdownInfo = { fg = colors.overlay1 },
		RenderMarkdownSuccess = { fg = colors.overlay1 },
		RenderMarkdownHint = { fg = colors.overlay1 },
		RenderMarkdownWarn = { fg = colors.overlay1 },
		RenderMarkdownError = { fg = colors.overlay1 },
		RenderMarkdownLink = { fg = colors.overlay1, underline = true },
		RenderMarkdownLinkTitle = { fg = colors.overlay1 },
		RenderMarkdownWikiLink = { fg = colors.overlay1, underline = true },
		RenderMarkdownTableHead = { fg = colors.text, bold = true },
		RenderMarkdownTableRow = { fg = colors.overlay1 },
		RenderMarkdownSign = { fg = colors.overlay1 },
		RenderMarkdownInlineHighlight = { bg = colors.surface0 },
		RenderMarkdownMath = { fg = colors.overlay1 },
		RenderMarkdownIndent = { fg = colors.surface0 },
		RenderMarkdownHtmlComment = { fg = colors.overlay0, italic = true },
		["@markup.heading.markdown"] = { fg = colors.text, bold = true },
		["@markup.heading.1.markdown"] = { fg = colors.text, bold = true },
		["@markup.heading.2.markdown"] = { fg = colors.text, bold = true },
		["@markup.heading.3.markdown"] = { fg = colors.text, bold = true },
		["@markup.heading.4.markdown"] = { fg = colors.text, bold = true },
		["@markup.heading.5.markdown"] = { fg = colors.text, bold = true },
		["@markup.heading.6.markdown"] = { fg = colors.text, bold = true },
		["@markup.link.markdown"] = { fg = colors.overlay1, underline = true },
		["@markup.link.label.markdown"] = { fg = colors.overlay1 },
		["@markup.list.markdown"] = { fg = colors.overlay1 },
		["@markup.quote.markdown"] = { fg = colors.overlay1 },
		["@markup.raw.markdown_inline"] = { fg = colors.text, bg = colors.surface0 },
	}

	for group, opts in pairs(highlights) do
		vim.api.nvim_set_hl(0, group, opts)
	end
end

return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {
			heading = {
				sign = false,
				width = "block",
				icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " },
				backgrounds = {
					"RenderMarkdownH1Bg",
					"RenderMarkdownH2Bg",
					"RenderMarkdownH3Bg",
					"RenderMarkdownH4Bg",
					"RenderMarkdownH5Bg",
					"RenderMarkdownH6Bg",
				},
			},
			code = {
				style = "normal",
				language_icon = false,
				border = "none",
			},
			dash = {
				width = 80,
			},
			bullet = {
				icons = { "•" },
			},
			checkbox = {
				unchecked = { icon = "☐ " },
				checked = { icon = "☑ " },
				custom = {
					todo = { raw = "[-]", rendered = "☐ ", highlight = "RenderMarkdownTodo" },
				},
			},
			quote = {
				icon = "│",
			},
			pipe_table = {
				style = "normal",
			},
			sign = {
				enabled = false,
			},
			win_options = {
				conceallevel = {
					rendered = 2,
				},
			},
		},
		config = function(_, opts)
			require("render-markdown").setup(opts)
			apply_markdown_highlights()
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "catppuccin",
				callback = apply_markdown_highlights,
			})
		end,
	},
}
