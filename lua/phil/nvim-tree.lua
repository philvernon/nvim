local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
    return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

local get_node = require('nvim-tree.lib').get_node_at_cursor
local has_children = function(node) return type(node.nodes) == 'table' and vim.tbl_count(node.nodes) > 0 end

local key_down = vim.api.nvim_replace_termcodes('j', true, true, true)

EC = {}

-- https://github.com/echasnovski/nvim/blob/fb9bbc2870f129e783d89e8f6071c22f3b501aa1/lua/ec/configs/nvim-tree.lua#L10-L35
EC.nvim_tree_go_in = function()

    local node = get_node()

    -- Don't go up if cursor is placed on '..'
    if node.name == '..' then
        vim.fn.feedkeys(key_down)
        return
    end

    -- Go inside if it is already an opened directory with children
    if has_children(node) and node.open == true then
        vim.fn.feedkeys(key_down)
        return
    end

    -- Peform 'edit' action
    nvim_tree.on_keypress('edit')

    -- Don't do anything if tree is not in focus
    if vim.api.nvim_buf_get_option(0, 'filetype') ~= 'NvimTree' then return end

    -- Go to first child node if it is a directory with children
    -- Get new node because before entries appear after first 'edit'
    node = get_node()
    if has_children(node) then vim.fn.feedkeys(key_down) end
end

nvim_tree.setup {
    -- update_focused_file = {
    --     enable = true,
    --     update_cwd = true,
    -- },
    update_focused_file = {
        enable = false
    },
    renderer = {
        root_folder_modifier = ":t",
        icons = {
            git_placement = "after",
            glyphs = {
                default = "",
                symlink = "",
                folder = {
                    arrow_open = "",
                    arrow_closed = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
                git = {
                    unstaged = "",
                    staged = "S",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "U",
                    deleted = "",
                    ignored = "◌",
                },
            },
        },
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    view = {
        width = 30,
        height = 30,
        side = "left",
        mappings = {
            list = {
                -- { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
                { key = 'l', cb = '<cmd>lua EC.nvim_tree_go_in()<CR>' },
                { key = "h", cb = tree_cb "close_node" },
                { key = "v", cb = tree_cb "vsplit" },
                { key = "<C-t>", action = "" }
            },
        },
    },
}
