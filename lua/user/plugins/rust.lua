return {
	"mrcjkb/rustaceanvim",
	version = "^9",
	lazy = false,
	init = function()
		vim.g.rustaceanvim = {
			tools = {
				float_win_config = {
					border = "rounded",
				},
			},
		}
	end,
}
