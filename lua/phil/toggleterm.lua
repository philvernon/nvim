local toggleterm = require("toggleterm")

require("toggleterm").setup({
	open_mapping = [[<c-\>]],
	direction = "horizontal",
	shade_terminals = true,
	persist_size = true,
})
