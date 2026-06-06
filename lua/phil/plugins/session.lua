return {
	"rmagatti/auto-session",
	event = "VeryLazy",
	config = function()
		require("auto-session").setup({
			auto_session_enable_last_session = true,
			auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/" },
			auto_session_use_git_branch = true,
			post_cwd_changed_hook = function()
				vim.schedule(function()
					require("lualine").refresh()
				end)
			end,
		})
	end,
}
