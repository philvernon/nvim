local clrs = require("catppuccin.palettes").get_palette()

local theme = require("catppuccin")

local SideBar = {
	init = function(self)
		self.mode = vim.fn.mode(1)
	end,
}

local ViMode = {
	-- get vim current mode, this information will be required by the provider
	-- and the highlight functions, so we compute it only once per component
	-- evaluation and store it as a component attribute
	init = function(self)
		self.mode = vim.fn.mode(1) -- :h mode()

		-- execute this only once, this is required if you want the ViMode
		-- component to be updated on operator pending mode
		if not self.once then
			vim.api.nvim_create_autocmd("ModeChanged", {
				pattern = "*:*o",
				command = "redrawstatus",
			})
			self.once = true
		end
	end,
	-- Now we define some dictionaries to map the output of mode() to the
	-- corresponding string and color. We can put these into `static` to compute
	-- them at initialisation time.
	static = {
		mode_names = { -- change the strings if you like it vvvvverbose!
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
	-- We can now access the value of mode() that, by now, would have been
	-- computed by `init()` and use it to index our strings dictionary.
	-- note how `static` fields become just regular attributes once the
	-- component is instantiated.
	-- To be extra meticulous, we can also add some vim statusline syntax to
	-- control the padding and make sure our string is always at least 2
	-- characters long. Plus a nice Icon.
	provider = function(self)
		return "▊ %2(" .. self.mode_names[self.mode] .. "%)"
	end,
	-- Same goes for the highlight. Now the foreground will change according to the current mode.
	hl = function(self)
		local mode = self.mode:sub(1, 1) -- get only the first mode character
		return { fg = self.mode_colors[mode], bold = true }
	end,
	-- Re-evaluate the component only on ModeChanged event!
	-- This is not required in any way, but it's there, and it's a small
	-- performance improvement.
	update = {
		"ModeChanged",
	},
}

local StatusLine = {
	ViMode,
}

require("heirline").setup(StatusLine)
