local toggleterm = require("toggleterm")

require("toggleterm").setup({
	open_mapping = [[<c-\>]],
	direction = "horizontal",
	shade_terminals = true,
	persist_size = true,
	winbar = {
		enabled = false,
		name_formatter = function(term) --  term: Terminal
			return term.name
		end,
	},
})
