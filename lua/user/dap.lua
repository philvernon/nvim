local dap = require("dap")
local dapui = require("dapui")

require("mason-nvim-dap").setup({
	ensure_installed = { "js" },
	automatic_installation = true,
})

-- local masondap = require('mason-nvim-dap')

-- Set keymaps to control the debugger
vim.keymap.set("n", "<bslash>dc", dap.continue)
vim.keymap.set("n", "<bslash>dso", dap.step_over)
vim.keymap.set("n", "<bslash>dsi", dap.step_into)
vim.keymap.set("n", "<bslash>dso", dap.step_out)
vim.keymap.set("n", "<bslash>dd", dap.toggle_breakpoint)
vim.keymap.set("n", "<bslash>dq", dap.clear_breakpoints)
vim.keymap.set("n", "<bslash>db", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)

dapui.setup()
-- dapui.setup({
-- 	layouts = {
-- 		-- {
-- 		-- elements = { {
-- 		-- 		id = "scopes",
-- 		-- 		size = 0.25
-- 		-- 	}, {
-- 		-- 		id = "breakpoints",
-- 		-- 		size = 0.25
-- 		-- 	}, {
-- 		-- 		id = "stacks",
-- 		-- 		size = 0.25
-- 		-- 	}, {
-- 		-- 		id = "watches",
-- 		-- 		size = 0.25
-- 		-- 	} },
-- 		-- 	position = "left",
-- 		-- 	size = 40
-- 		-- },
-- 		{
-- 			elements = { {
-- 				id = "repl",
-- 				size = 0.5
-- 			},
-- 				-- {
-- 				-- 	id = "console",
-- 				-- 	size = 0.5
-- 				-- }
-- 			},
-- 			position = "bottom",
-- 			size = 10
-- 		}
-- 	},
-- })

vim.api.nvim_create_autocmd("User", {
	group = vim.api.nvim_create_augroup("dap-status", { clear = true }),
	pattern = "DapProgressUpdate",
	command = "redrawstatus",
})

local js_based_languages = { "typescript", "javascript", "typescriptreact", "vue" }

-- dap.adapters['nuxt'] = {
-- 	type = 'server',
-- 	host = '127.0.0.1',
-- 	port = 3000,
-- }
dap.adapters.chrome = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/bin/vscode-chrome-debug/out/src/chromeDebug.js" }, -- TODO adjust
}

dap.adapters.firefox = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/bin/vscode-firefox-debug/dist/adapter.bundle.js" },
}

for _, language in ipairs(js_based_languages) do
	dap.configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
		},
		{
			type = "chrome",
			request = "launch",
			name = "client: chrome",
			url = "http://localhost:3333",
			webRoot = "${workspaceFolder}",
			console = "integratedTerminal",
		},
		{
			type = "not-chrome",
			request = "launch",
			name = 'Start Chrome with "localhost"',
			url = "http://localhost:3000",
			webRoot = "${workspaceFolder}",
			-- userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
		},
	}
end

-- dap.configurations.javascript = { -- change this to javascript if needed
-- 	{
-- 		name = "js",
-- 		type = "chrome",
-- 		request = "attach",
-- 		program = "${file}",
-- 		cwd = vim.fn.getcwd(),
-- 		sourceMaps = true,
-- 		protocol = "inspector",
-- 		port = 9222,
-- 		webRoot = "${workspaceFolder}"
-- 	}
-- }

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close({})
end

vim.keymap.set("n", "<leader>ui", require("dapui").toggle)

--
--
-- dap.configurations.typescriptreact = { -- change to typescript if needed
--   {
--     type = "chrome",
--     request = "attach",
--     program = "${file}",
--     cwd = vim.fn.getcwd(),
--     sourceMaps = true,
--     protocol = "inspector",
--     port = 9222,
--     webRoot = "${workspaceFolder}"
--   }
-- }
--
-- dapui.setup()
