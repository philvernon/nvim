local core = require("pi-sessions")
local renderer = require("neo-tree.ui.renderer")
local common = require("neo-tree.sources.common.components")

local M = {
	name = "pi_sessions",
	display_name = "  Pi ",
	components = common,
}

local function toggle(state, node)
	if node:is_expanded() then
		node:collapse()
	else
		node:expand()
	end
	renderer.redraw(state)
end

local function collapse(state)
	local node = state.tree:get_node()
	if not node then
		return
	end
	if node.type == "project" and node:is_expanded() then
		node:collapse()
		renderer.redraw(state)
		return
	end
	local parent = node:get_parent_id()
	if parent then
		renderer.focus_node(state, parent)
	end
end

M.commands = {
	open = function(state)
		local node = state.tree:get_node()
		if not node then
			return
		end
		if node.type == "session" then
			renderer.close(state)
			core.resume(node.extra.session)
		elseif node.type == "project" then
			toggle(state, node)
		end
	end,
	new = function(state)
		local node = state.tree:get_node()
		if not node then
			return
		end
		local project = node.extra and node.extra.project
		if project then
			renderer.close(state)
			core.new(project)
		end
	end,
	collapse = collapse,
	navigate_up = collapse,
	refresh = function(state)
		M.navigate(state)
	end,
	close_window = function(state)
		renderer.close(state)
	end,
}

M.default_config = {
	window = {
		position = "float",
		mappings = {
			["<cr>"] = "open",
			["l"] = "open",
			["n"] = "new",
			["R"] = "refresh",
			["q"] = "close_window",
			["<esc>"] = "close_window",
		},
	},
	renderers = {
		project = {
			{ "indent", with_expanders = true },
			{ "name", highlight = "NeoTreeDirectoryName" },
		},
		session = {
			{ "indent" },
			{ "name", highlight = "NeoTreeFileName" },
		},
	},
}

function M.navigate(state, _, _, callback)
	local snapshot = core.scan()
	local nodes = {}
	state.default_expanded_nodes = {}

	for _, project in ipairs(snapshot.projects) do
		local project_id = "project:" .. project.cwd
		local children = {}
		for _, session in ipairs(project.sessions) do
			children[#children + 1] = {
				id = session.path,
				name = session.label,
				type = "session",
				loaded = true,
				extra = { session = session, project = project },
			}
		end
		nodes[#nodes + 1] = {
			id = project_id,
			name = project.name,
			type = "project",
			loaded = true,
			children = children,
			extra = { project = project },
		}
		state.default_expanded_nodes[#state.default_expanded_nodes + 1] = project_id
	end

	state.path = core.root()
	renderer.show_nodes(nodes, state)
	if callback then
		vim.schedule(callback)
	end
end

function M.setup() end

function M.open()
	require("neo-tree.command").execute({
		action = "focus",
		source = M.name,
		position = "float",
	})
end

return M
