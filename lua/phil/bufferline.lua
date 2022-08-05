vim.opt.termguicolors = true

require("bufferline").setup {
    options = {
        show_close_icon = false,
        show_buffer_close_icons = false,
        offsets = {
            {
                filetype = "NvimTree",
                text = "",
                highlight = "Directory",
                text_align = "left"
            }
        }
    }
}
