return {
	"rebelot/heirline.nvim",
	event = "VeryLazy",
	config = function()
		local clrs = require("catppuccin.palettes").get_palette()

		local theme = require("catppuccin")

		local SideBar = {
			init = function(self)
				self.mode = vim.fn.mode(1)
			end,
		}

		local ViMode = {
			init = function(self)
				self.mode = vim.fn.mode(1)

				if not self.once then
					vim.api.nvim_create_autocmd("ModeChanged", {
						pattern = "*:*o",
						command = "redrawstatus",
					})
					self.once = true
				end
			end,
			static = {
				mode_names = {
					n = "N",
					no = "N?",
					nov = "N?",
					noV = "N?",
					["no\22"] = "N?",
					niI = "Ni",
					niR = "Nr",
					niV = "Nv",
					nt = "Nt",
					v = "V",
					vs = "Vs",
					V = "V_",
					Vs = "Vs",
					["\22"] = "^V",
					["\22s"] = "^V",
					s = "S",
					S = "S_",
					["\19"] = "^S",
					i = "I",
					ic = "Ic",
					ix = "Ix",
					R = "R",
					Rc = "Rc",
					Rx = "Rx",
					Rv = "Rv",
					Rvc = "Rv",
					Rvx = "Rv",
					c = "C",
					cv = "Ex",
					r = "...",
					rm = "M",
					["r?"] = "?",
					["!"] = "!",
					t = "T",
				},
				mode_colors = {
					n = clrs.lavender,
					no = clrs.lavender,
					i = clrs.green,
					ic = clrs.green,
					t = clrs.green,
					v = clrs.flamingo,
					V = clrs.flamingo,
					[""] = clrs.flamingo,
					R = clrs.maroon,
					Rv = clrs.maroon,
					s = clrs.maroon,
					S = clrs.maroon,
					[""] = clrs.maroon,
					c = clrs.peach,
					cv = clrs.peach,
					ce = clrs.peach,
					r = clrs.teal,
					rm = clrs.teal,
					["r?"] = clrs.mauve,
					["!"] = clrs.green,
				},
			},
			provider = function(self)
				return "▊ %2(" .. self.mode_names[self.mode] .. "%)"
			end,
			hl = function(self)
				local mode = self.mode:sub(1, 1)
				return { fg = self.mode_colors[mode], bold = true }
			end,
			update = {
				"ModeChanged",
			},
		}

		local StatusLine = {
			ViMode,
		}

		require("heirline").setup(StatusLine)
	end,
}
