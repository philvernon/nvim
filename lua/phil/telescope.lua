local colors = require("catppuccin.palettes").get_palette()
local action_layout = require("telescope.actions.layout")
local action = require("telescope.actions")
-- local trouble = require("trouble.providers.telescope")
local openTrouble = require("trouble.sources.telescope").open

local TelescopeColor = {
	-- TelescopeMatching = { fg = colors.flamingo },
	TelescopeTitle = { fg = colors.surface2 },
	TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },
	--
	TelescopePromptPrefix = { bg = colors.mantle },
	TelescopePromptNormal = { bg = colors.mantle },
	TelescopeResultsNormal = { bg = colors.mantle },
	TelescopePreviewNormal = { bg = colors.mantle },
	TelescopePromptBorder = { bg = colors.mantle, fg = colors.mantle },
	TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
	TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
	TelescopeSelectionCaret = { fg = colors.mantle },
	-- TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
	-- TelescopeResultsTitle = { fg = colors.mantle },
	-- TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
}

for hl, col in pairs(TelescopeColor) do
	vim.api.nvim_set_hl(0, hl, col)
end
require("telescope").setup({
	defaults = {
		results_title = false,
		prompt_prefix = " ",
		selection_caret = ". ",
		layout_strategy = "center",
		cycle_layout_list = { "horizontal", "center", "cursor" },
		layout_config = {
			center = {
				prompt_position = "bottom",
			},
			horizontal = {
				-- width = 0.5
				-- prompt_position = "top",
			},
			cursor = {
				height = 0.01,
			},
		},
		-- border = false,
		preview = {
			hide_on_startup = true,
		},
		path_display = {
			truncate = 3,
		},
		mappings = {
			n = {
				["p"] = action_layout.toggle_preview,
				["<C-f>"] = "close",
				["]"] = action_layout.cycle_layout_next,
				["["] = action_layout.cycle_layout_prev,
				["gq"] = action.send_selected_to_qflist + action.open_qflist,
				["<C-t>"] = openTrouble,
			},
			i = {
				["<C-f>"] = "close",
				["<C-t>"] = openTrouble,
			},
		},
		extensions = {
			project = {
				layout_strategy = "horizontal",
			},
			["ui-select"] = {
				layout_strategy = "cursor",
				-- require("telescope.themes").get_cursor({
				-- 	-- even more opts
				-- }),
			},
		},
	},
})

require("telescope").load_extension("luasnip")
require("telescope").load_extension("project")
require("telescope").load_extension("ui-select")
