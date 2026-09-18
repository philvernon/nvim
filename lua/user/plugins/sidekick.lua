return {
	"folke/sidekick.nvim",
	init = function() vim.env.PATH = vim.fn.expand("~/.config/nvim/utils/sidekick-tmux") .. ":" .. vim.env.PATH end,
	opts = {
		-- add any options here
		cli = {
			win = {
				keys = {
					prompt = { "<leader>ap", "prompt", mode = "n", desc = "insert prompt or context" },
					toggle_n = {
						"<c-p>",
						function() require("sidekick.cli").focus({ name = "pi" }) end,
						mode = "nt",
					},
				},
				split = {
					width = 0, -- set to 0 for default split width
					height = 0, -- set to 0 for default split height
				},
			},
			mux = {
				backend = "tmux",
				enabled = true,
				create = "terminal",
			},
			tools = {
				pi = {
					cmd = { "pi", "--tui-mode", "regular" },
				},
			},
		},
	},
	keys = {
		{
			"<tab>",
			function()
				-- if there is a next edit, jump to it, otherwise apply it if any
				if not require("sidekick").nes_jump_or_apply() then
					return "<Tab>" -- fallback to normal tab
				end
			end,
			expr = true,
			desc = "Goto/Apply Next Edit Suggestion",
		},
		{
			"<c-.>",
			function() require("sidekick.cli").focus() end,
			desc = "Sidekick Focus",
			mode = { "n", "t", "i", "x" },
		},
		{
			"<leader>aa",
			function() require("sidekick.cli").toggle() end,
			desc = "Sidekick Toggle CLI",
		},
		{
			"<leader>as",
			function() require("sidekick.cli").select({ filter = { installed = true } }) end,
			-- Or to select only installed tools:
			-- require("sidekick.cli").select({ filter = { installed = true } })
			desc = "Select CLI",
		},
		{
			"<leader>ad",
			function() require("sidekick.cli").close() end,
			desc = "Detach a CLI Session",
		},
		{
			"<leader>at",
			function() require("sidekick.cli").send({ msg = "{this}" }) end,
			mode = { "x", "n" },
			desc = "Send This",
		},
		{
			"<leader>af",
			function() require("sidekick.cli").send({ msg = "{file}" }) end,
			desc = "Send File",
		},
		{
			"<leader>av",
			function() require("sidekick.cli").send({ msg = "{selection}" }) end,
			mode = { "x" },
			desc = "Send Visual Selection",
		},
		{
			"<leader>ap",
			function() require("sidekick.cli").prompt() end,
			mode = { "n", "x" },
			desc = "Sidekick Select Prompt",
		},
	},
}
