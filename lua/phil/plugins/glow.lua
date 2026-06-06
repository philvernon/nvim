return {
	"ellisonleao/glow.nvim",
	event = "VeryLazy",
	config = function()
		require("glow").setup({
			-- your override config
		})
	end,
}
