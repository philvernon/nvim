vim.opt.termguicolors = true

require("bufferline").setup({
	options = {
		-- mode = "tabs",
		show_close_icon = false,
		always_show_bufferline = true,
		show_buffer_close_icons = false,
		offsets = {
			{
				filetype = "NvimTree",
				text = "",
				highlight = "Directory",
				text_align = "left",
			},
		},
	},
})
