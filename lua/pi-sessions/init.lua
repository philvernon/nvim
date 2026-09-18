local M = {}

local function root()
	return vim.fs.normalize(vim.env.PI_CODING_AGENT_SESSION_DIR or vim.fn.expand("~/.pi/agent/sessions"))
end

local function timestamp(ts)
	if not ts or ts == "" then
		return "unknown"
	end
	return ts:gsub("T", " "):gsub("%.000Z$", "Z")
end

local function message_text(message)
	if type(message) ~= "table" or message.role ~= "user" then
		return
	end
	if type(message.content) == "string" then
		return message.content
	end
	if type(message.content) == "table" then
		local text = {}
		for _, part in ipairs(message.content) do
			if type(part) == "table" and part.type == "text" and type(part.text) == "string" then
				text[#text + 1] = part.text
			end
		end
		return table.concat(text, " ")
	end
end

local preview_cache = {}

local function content_text(content)
	if type(content) == "string" then
		return content
	end
	if type(content) ~= "table" then
		return
	end

	local parts = {}
	for _, part in ipairs(content) do
		if type(part) == "table" and part.type == "text" and type(part.text) == "string" then
			parts[#parts + 1] = part.text
		end
	end
	return #parts > 0 and table.concat(parts, "\n") or nil
end

local function preview_block(lines, heading, body)
	if not body or body == "" then
		return
	end
	lines[#lines + 1] = "## " .. heading
	vim.list_extend(lines, vim.split(vim.trim(body), "\n", { plain = true }))
	lines[#lines + 1] = ""
end

local function render_preview_entry(lines, entry)
	if entry.type == "compaction" then
		preview_block(lines, "Summary", entry.summary)
		return
	elseif entry.type == "branch_summary" then
		preview_block(lines, "Branch summary", entry.summary)
		return
	elseif entry.type ~= "message" or type(entry.message) ~= "table" then
		return
	end

	local message = entry.message
	if message.role == "user" then
		preview_block(lines, "User", content_text(message.content))
	elseif message.role == "assistant" then
		preview_block(lines, "Assistant", content_text(message.content))
		if type(message.content) == "table" then
			for _, part in ipairs(message.content) do
				if type(part) == "table" and (part.type == "toolCall" or part.type == "tool_call") then
					local args = part.arguments or part.input
					local detail = type(args) == "table" and (args.path or args.file_path or args.command or args.query) or nil
					lines[#lines + 1] = ("### Tool: %s%s"):format(
						part.name or part.toolName or "unknown",
						detail and (" " .. tostring(detail)) or ""
					)
					lines[#lines + 1] = ""
				end
			end
		end
	elseif message.role == "toolResult" and message.isError then
		preview_block(lines, "Tool error: " .. (message.toolName or "unknown"), content_text(message.content))
	elseif message.role == "bashExecution" then
		lines[#lines + 1] = "### Tool: bash " .. (message.command or "")
		lines[#lines + 1] = ""
	elseif message.role == "branchSummary" then
		preview_block(lines, "Branch summary", message.summary)
	elseif message.role == "compactionSummary" then
		preview_block(lines, "Summary", message.summary)
	end
end

local function read_session(path)
	local file = io.open(path, "r")
	if not file then
		return
	end

	local header, name, first_message
	for line in file:lines() do
		if not header or not first_message or line:find('"session_info"', 1, true) then
			local ok, item = pcall(vim.json.decode, line)
			if ok and type(item) == "table" then
				if not header and item.type == "session" then
					header = item
				elseif item.type == "session_info" then
					name = type(item.name) == "string" and vim.trim(item.name) or nil
					if name == "" then
						name = nil
					end
				elseif not first_message and item.type == "message" then
					first_message = message_text(item.message)
				end
			end
		end
	end
	file:close()

	if not header or not header.cwd or not header.id then
		return
	end

	name = name or first_message
	if name then
		name = name:gsub("%s+", " ")
	end
	local session = {
		id = header.id,
		path = path,
		cwd = header.cwd,
		timestamp = header.timestamp,
		name = name,
	}
	session.label = ("%s  %s"):format(name or header.id:sub(1, 8), timestamp(header.timestamp))
	return session
end

function M.root()
	return root()
end

function M.scan()
	local sessions = {}
	for _, path in ipairs(vim.fn.globpath(root(), "**/*.jsonl", false, true)) do
		local session = read_session(path)
		if session then
			sessions[#sessions + 1] = session
		end
	end

	table.sort(sessions, function(a, b)
		return (a.timestamp or "") > (b.timestamp or "")
	end)

	local by_cwd, projects = {}, {}
	for _, session in ipairs(sessions) do
		local project = by_cwd[session.cwd]
		if not project then
			project = {
				cwd = session.cwd,
				name = vim.fn.fnamemodify(session.cwd, ":~"),
				sessions = {},
			}
			by_cwd[session.cwd] = project
			projects[#projects + 1] = project
		end
		project.sessions[#project.sessions + 1] = session
	end

	return { sessions = sessions, projects = projects }
end

function M.all()
	return M.scan().sessions
end

function M.projects()
	return M.scan().projects
end

function M.sessions(project)
	local cwd = type(project) == "table" and project.cwd or project
	for _, item in ipairs(M.scan().projects) do
		if item.cwd == cwd then
			return item.sessions
		end
	end
	return {}
end

function M.preview(session)
	local stat = vim.uv.fs_stat(session.path)
	if not stat then
		return { "Session file not found" }
	end

	local key = ("%d:%d:%d"):format(stat.size, stat.mtime.sec, stat.mtime.nsec)
	local cached = preview_cache[session.path]
	if cached and cached.key == key then
		return cached.lines
	end

	local file = io.open(session.path, "r")
	if not file then
		return { "Unable to read session" }
	end

	local header, leaf = nil, nil
	local entries, ordered = {}, {}
	for line in file:lines() do
		local ok, entry = pcall(vim.json.decode, line)
		if ok and type(entry) == "table" then
			if entry.type == "session" then
				header = entry
			elseif entry.id then
				entries[entry.id] = entry
				ordered[#ordered + 1] = entry
				leaf = entry
			end
		end
	end
	file:close()

	local branch = {}
	if header and header.version == 1 then
		branch = ordered
	else
		local seen = {}
		while leaf and leaf.id and not seen[leaf.id] do
			seen[leaf.id] = true
			branch[#branch + 1] = leaf
			leaf = leaf.parentId and entries[leaf.parentId] or nil
		end
		for i = 1, math.floor(#branch / 2) do
			branch[i], branch[#branch - i + 1] = branch[#branch - i + 1], branch[i]
		end
	end

	local lines = {}
	for _, entry in ipairs(branch) do
		render_preview_entry(lines, entry)
	end
	if #lines == 0 then
		lines = { "No previewable messages" }
	elseif #lines > 500 then
		lines = vim.list_slice(lines, #lines - 498, #lines)
		table.insert(lines, 1, "… older preview omitted")
	end

	preview_cache[session.path] = { key = key, lines = lines }
	return lines
end

local function launch(cwd, args)
	local Config = require("sidekick.config")
	local Session = require("sidekick.cli.session")
	local State = require("sidekick.cli.state")

	Session.setup()

	local tool = Config.get_tool("pi")
	local cmd = vim.deepcopy(tool.cmd)
	vim.list_extend(cmd, args or {})

	local session = Session.new({
		tool = tool:clone({ cmd = cmd }),
		cwd = cwd,
	})

	return State.attach(State.get_state(session), { show = true, focus = true })
end

function M.resume(session)
	assert(session and session.path and session.cwd, "invalid Pi session")
	return launch(session.cwd, { "--session", session.path })
end

function M.new(project)
	local cwd = type(project) == "table" and project.cwd or project
	assert(cwd and cwd ~= "", "invalid Pi project")
	return launch(cwd, {})
end

function M.setup(opts)
	opts = opts or {}
	vim.api.nvim_create_user_command("PiSessions", function(cmd)
		local integration = cmd.args ~= "" and cmd.args or opts.integration or "neo-tree"
		if integration == "neotree" then
			integration = "neo-tree"
		end
		require("pi-sessions.integrations." .. integration).open()
	end, {
		nargs = "?",
		force = true,
		complete = function()
			return { "neo-tree", "telescope" }
		end,
	})
end

return M
