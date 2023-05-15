vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
local colors = require("catppuccin.palettes").get_palette()

local NeoTreeColours = {
	NeoTreeNormal = { fg = colors.text, bg = colors.mantle, bold = true },
	NeoTreeFloatBorder = { bg = colors.mantle, fg = colors.mantle },
}

for hl, col in pairs(NeoTreeColours) do
	vim.api.nvim_set_hl(0, hl, col)
end

-- If you want icons for diagnostic errors, you'll need to define them somewhere:
vim.fn.sign_define("DiagnosticSignError",
{text = " ", texthl = "DiagnosticSignError"})
vim.fn.sign_define("DiagnosticSignWarn",
{text = " ", texthl = "DiagnosticSignWarn"})
vim.fn.sign_define("DiagnosticSignInfo",
{text = " ", texthl = "DiagnosticSignInfo"})
vim.fn.sign_define("DiagnosticSignHint",
{text = "", texthl = "DiagnosticSignHint"})

require("neo-tree").setup({
  filesystem = {
    find_by_full_path_words = true,
   -- hijack_netrw_behavior = "open_current",
    filtered_items = {
      visible = false, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
      hide_dotfiles = false,
      hide_gitignored = true,
    },
    window = {
      popup = {
        position = { col = "50%", row = "50%" },
        size = function(state)
          local root_name = vim.fn.fnamemodify(state.path, ":~")
          local root_len = string.len(root_name) + 4
          return {
            width = math.max(root_len, 100),
            height = math.max(math.floor(vim.o.lines / 2 + 4), 10)
          }
        end
      },
    }
  },
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  default_component_configs = {
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "ﰊ",
      default = "*",
      highlight = "NeoTreeFileIcon"
    },
    modified = {
      symbol = "[+]",
      -- highlight = "NeoTreeModified",
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = false,
      highlight = "NeoTreeFileName",
    },
    git_status = {
      symbols = {
        unstaged = "",
        staged = "S",
        unmerged = "",
        renamed = "➜",
        untracked = "U",
        deleted = "",
        ignored = "◌",
        -- Change type
        added     = "+", -- or "✚", but this is redundant info if you use git_status_colors on the name
        modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
        conflict  = "C",
      }
    }
  },
  window = {
    position = "float",
    width = 5,
    height = 5,
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      ["<C-t>"] = "close_window",
      ["<esc>"] = "close_window",
      ["<Tab>"] = "close_window",
      ["o"] = "navigate_up",
      ["h"] = function(state)
        local node = state.tree:get_node()
        if node.type == 'directory' and node:is_expanded() then
          require'neo-tree.sources.filesystem'.toggle_directory(state, node)
        else
          require'neo-tree.ui.renderer'.focus_node(state, node:get_parent_id())
          require'neo-tree.sources.filesystem'.toggle_directory(state, node.parent)
        end
      end,
      ["l"] = function(state)
        local node = state.tree:get_node()
        if node.type == 'directory' then
          if not node:is_expanded() then
            require'neo-tree.sources.filesystem'.toggle_directory(state, node)
            require'neo-tree.ui.renderer'.focus_node(state, node:get_child_ids()[1])
          elseif node:has_children() then
            require'neo-tree.ui.renderer'.focus_node(state, node:get_child_ids()[1])
          end
        elseif node.type == 'file' then
          require'neo-tree.utils'.open_file(state, node.path, "e")
        end
      end,
    }
  }
})
