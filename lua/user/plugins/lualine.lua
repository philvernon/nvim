return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "catppuccin/nvim", name = "catppuccin" },
	config = function()
		local lualine = require("lualine")
		local cp = require("catppuccin.palettes").get_palette()

		-- Catppuccin palette (Mocha)
		local C = {
			bg       = cp.base,
			text     = cp.text,
			subtext0 = cp.subtext0,
			surface2 = cp.surface2,
			lavender = cp.lavender,
			green    = cp.green,
			flamingo = cp.flamingo,
			maroon   = cp.maroon,
			peach    = cp.peach,
			teal     = cp.teal,
			mauve    = cp.mauve,
			blue     = cp.blue,
		}

		-- Mode display names (abbreviated)
		local mode_names = {
			n   = "N",  no      = "N?",  nov   = "N?",  noV   = "N?",
			["no\22"] = "N?", niI   = "Ni",  niR   = "Nr",  niV   = "Nv",  nt = "Nt",
			v   = "V",  vs      = "Vs",  V       = "V_",  Vs    = "Vs",
			["\22"]   = "^V", ["\22s"] = "^V", s     = "S",   S       = "S_",
			["\19"]   = "^S", i     = "I",   ic      = "Ic",  ix = "Ix",
			R   = "R",  Rc      = "Rc",  Rx      = "Rx",  Rv   = "Rv",
			Rvc = "Rv", Rvx     = "Rv",  c       = "C",   cv   = "Ex",
			r   = "...", rm     = "M",   ["r?"]  = "?",   ["!"] = "!",
			t   = "T",
		}

		-- Mode -> accent color
		local mode_colors = {
			n   = C.lavender, no    = C.lavender, i   = C.green, ic  = C.green, t = C.green,
			v   = C.flamingo, V     = C.flamingo, ["\22"] = C.flamingo,
			R   = C.maroon,   Rv    = C.maroon,   s   = C.maroon, S   = C.maroon,
			["\19"] = C.maroon,
			c   = C.peach,    cv    = C.peach,    ce  = C.peach,
			r   = C.teal,     rm    = C.teal,     ["r?"] = C.mauve,
			["!"] = C.green,
		}

		-- Conditions
		local conditions = {
			buffer_not_empty = function()
				return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
			end,
			hide_in_width = function()
				return vim.fn.winwidth(0) > 80
			end,
			check_git_workspace = function()
				local filepath = vim.fn.expand("%:p:h")
				local gitdir = vim.fn.finddir(".git", filepath .. ";")
				return gitdir and #gitdir > 0 and #gitdir < #filepath
			end,
		}

		-- Filetypes where lualine should be disabled
		local disallowed_filetypes = { "packer", "neo-tree filesystem", "toggleterm", "outline" }

		-- Minimal theme: all sections share the same base style
		local theme_base = { bg = "None", gui = "bold" }
		local theme = {}
		for _, mode in ipairs({ "normal", "insert", "visual", "replace", "command", "inactive" }) do
			theme[mode] = { a = theme_base, b = theme_base, c = theme_base, x = theme_base, y = theme_base, z = theme_base }
		end

		-- Build config
		local config = {
			extensions      = { "nvim-tree" },
			globalstatus      = true,
			options           = {
				disabled_filetypes = { statusline = disallowed_filetypes, winbar = disallowed_filetypes },
				component_separators = "",
				section_separators  = "",
				theme               = theme,
			},
			sections = {
				lualine_a = {}, lualine_b = {}, lualine_c = {},
				lualine_x = {}, lualine_y = {}, lualine_z = {},
			},
			inactive_sections = table.deepcopy(config.sections),
			winbar = {
				lualine_c = {
					{ "filename",
						color     = { gui = "bold", fg = C.text },
						symbols   = { modified = "●", newfile = "" },
					},
				},
				lualine_x = {},
			},
			inactive_winbar = {
				lualine_c = {
					{ "filename",
						color     = { gui = "bold", fg = C.surface2, bg = C.bg },
						symbols   = { modified = "●", newfile = "" },
					},
				},
				lualine_z = {},
			},
		}

		-- Helpers
		local function ins_left(comp)
			table.insert(config.sections.lualine_c, comp)
		end
		local function ins_right(comp)
			table.insert(config.sections.lualine_x, comp)
		end
		local function mode_to_color()
			return { fg = mode_colors[vim.fn.mode()] }
		end

		-- Left side: mode indicator + branch + filename + diff
		ins_left({
			function() return "▊" end,
			color = mode_to_color,
			padding = { left = 0, right = 1 },
		})
		ins_left({
			function() return mode_names[vim.fn.mode()] end,
			padding = { right = 1 },
		})

		ins_left({ "branch", icon = "", color = { fg = C.blue, gui = "bold" } })
		ins_left({
			"filename",
			cond           = conditions.buffer_not_empty,
			color          = { fg = C.subtext0, gui = "bold" },
			path           = 1,
			shorting_target = 150,
		})
		ins_left({
			"diff",
			symbols        = { added = "+", modified = "~", removed = "-" },
			fmt            = function(str)
				-- Strip diff markers, right-align in 3-char field
				local clean = str:gsub("[+~-]", "")
				return string.format("%3s", clean)
			end,
			diff_color     = {
				added    = { fg = C.green },
				modified = { fg = C.peach },
				removed  = { fg = C.maroon },
			},
			cond           = conditions.hide_in_width,
		})

		-- Right side: diagnostics + filetype + lsp + location + lines + progress
		ins_right({
			"diagnostics",
			sources        = { "nvim_diagnostic" },
			symbols        = { error = "", warn = "", info = "", hint = "" },
			diagnostics_color = {
				color_error  = { fg = C.maroon },
				color_warn   = { fg = C.peach },
				color_info   = { fg = C.teal },
			},
		})
		ins_right({ "filetype", color = { fg = C.subtext0 } })

		-- LSP clients (skip null-ls)
		ins_right({
			function()
				local clients = vim.lsp.get_clients()
				if not next(clients) then return "" end
				local names = {}
				for _, client in ipairs(clients) do
					if client.name ~= "null-ls" then
						table.insert(names, client.name)
					end
				end
				return table.concat(names, " ")
			end,
			color = { fg = C.subtext0, gui = "bold" },
			padding = 0,
		})

		ins_right({ "location", color = { fg = C.subtext0 } })

		-- Line count (from the statusline window)
		ins_right({
			function()
				local buf = vim.fn.winbufnr(vim.g.statusline_winid or 0)
				return tostring(vim.api.nvim_buf_line_count(buf))
			end,
			color = { fg = C.subtext0 },
		})

		ins_right({ "progress", color = { fg = C.subtext0, gui = "bold" } })
		ins_right({
			function() return " ▊" end,
			color = mode_to_color,
			padding = { left = 1 },
		})

		lualine.setup(config)
	end,
}
