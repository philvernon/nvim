return {
	"mfussenegger/nvim-dap",
	lazy = false,
	dependencies = {
		"jay-babu/mason-nvim-dap.nvim",
		{
			"rcarriga/nvim-dap-ui",
			dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
			event = "VeryLazy",
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("mason-nvim-dap").setup({
			ensure_installed = { "js" },
			automatic_installation = true,
		})

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

		vim.api.nvim_create_autocmd("User", {
			group = vim.api.nvim_create_augroup("dap-status", { clear = true }),
			pattern = "DapProgressUpdate",
			command = "redrawstatus",
		})

		local js_based_languages = { "typescript", "javascript", "typescriptreact", "vue" }

		dap.adapters.chrome = {
			type = "executable",
			command = "node",
			args = { os.getenv("HOME") .. "/bin/vscode-chrome-debug/out/src/chromeDebug.js" },
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
				},
			}
		end

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
	end,
}
