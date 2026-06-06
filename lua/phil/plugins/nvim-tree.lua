return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	event = "VeryLazy",
	config = function()
		local nvim_tree = require("nvim-tree")

		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		nvim_tree.setup({
			hijack_netrw = true,
			git = { enable = false },
			view = {
				width = 30,
				side = "left",
				preserve_window_proportions = true,
			},
			renderer = {
				root_folder_label = false,
				indent_markers = { enable = false },
				icons = {
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
					},
				},
			},
			filters = { dotfiles = false },
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")

				local function opts(desc)
					return { buffer = bufnr, silent = true, desc = desc }
				end

				vim.keymap.set("n", "<bslash>l", api.tree.change_root_to_node, opts("CD"))
				vim.keymap.set("n", "e", api.node.show_info_popup, opts("INFO"))
				vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
				vim.keymap.set("n", "<bslash>o", api.node.open.edit, opts("Open"))
				vim.keymap.set("n", "t", api.node.open.tab, opts("Open Tab"))
				vim.keymap.set("n", "v", api.node.open.split, opts("Open Split"))
				vim.keymap.set("n", "<bslash>v", api.node.open.split, opts("Open Split"))
				vim.keymap.set("n", "q", api.tree.close, opts("Close Tree"))
				vim.keymap.set("n", "r", api.tree.refresh, opts("Refresh"))
				vim.keymap.set("n", "m", api.marks.toggle, opts("Toggle Mark"))
				vim.keymap.set("n", "<bslash>d", api.tree.toggle_hidden, opts("Reveal Hidden"))
				vim.keymap.set("n", "D", api.tree.remove, opts("Delete"))

				vim.keymap.set("n", "[c", api.tree.prev_git_node, opts("Prev Git Node"))
				vim.keymap.set("n", "]c", api.tree.next_git_node, opts("Next Git Node"))

				local EC = require("phil.plugins.ec")

				vim.keymap.set("n", "<bslash>n", function()
					EC.nvim_tree_go_in()
				end, { desc = "nvim tree go in" })
			end,
		})
	end,
}
