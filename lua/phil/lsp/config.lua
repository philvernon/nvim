local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	-- require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
end

local mason_registry = require("mason-registry")
mason_registry.refresh()
mason_registry.update()
-- local has_volar, volar = pcall(mason_registry.get_package, "vue-language-server")

vim.diagnostic.config({
	virtual_text = false,
	update_in_insert = true,
	underline = true,
	severity_sort = false,
	float = {
		border = "rounded",
		source = true,
		header = "",
		prefix = "",
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = "󰌵",
		},
	},
})

require("lspconfig").yamlls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		yaml = {
			format = {
				enable = true,
			},
		},
	},
})

local base_on_attach = vim.lsp.config.eslint.on_attach
lspconfig.eslint.setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		if not base_on_attach then
			return
		end

		base_on_attach(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "LspEslintFixAll",
		})
	end,
	root_dir = function()
		return vim.fn.getcwd() -- Use the current working directory
	end,
	settings = {
		workingDirectories = { mode = "auto" }, -- Helps with multi-project monorepos
		experimental = {
			useFlatConfig = true,
		},
	},
})

-- local vue_ts_plugin_path = vim.fn.expand("$MASON")
-- 	.. "/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"
--
-- print(vue_ts_plugin_path)
--
-- lspconfig.ts_ls.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	filetypes = { "typescript", "javascript", "json", "vue", "javascriptreact", "typescriptreact" },
-- 	init_options = {
-- 		plugins = {
-- 			{
-- 				name = "@vue/typescript-plugin",
-- 				location = vue_ts_plugin_path,
-- 				languages = { "vue" },
-- 			},
-- 		},
-- 	},
-- })
--
-- lspconfig.vue_ls.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	flags = {
-- 		debounce_text_changes = 150,
-- 	},
-- 	filetypes = { "vue" },
-- })

require("lspconfig").lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	-- root_dir = function(fname)
	--   local root_pattern = require 'lspconfig'.util.root_pattern('.git', '*.rockspec')(fname)
	--
	--   if fname == vim.loop.os_homedir() then return nil end
	--   return root_pattern or fname
	-- end,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				-- library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

require("lspconfig").marksman.setup({
	on_attach = on_attach,
})

require("lspconfig").gopls.setup({
	on_attach = on_attach,
	settings = {
		gopls = {
			buildFlags = { "-tags=configtool" },
		},
	},
})

require("lspconfig").bashls.setup({
	on_attach = on_attach,
})

require("lspconfig").html.setup({
	capabilities = capabilities,
})

require("lspconfig").cssls.setup({
	capabilities = capabilities,
})

require("lspconfig").gdscript.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 150,
	},
})

require("lspconfig").efm.setup({
	on_attach = on_attach,
	flags = {
		debounce_text_changes = 150,
	},
	filetypes = { "gdscript" },

	init_options = { documentFormatting = true },
	settings = {
		rootMarkers = { ".git/" },
		languages = {
			gdscript = {
				{ formatCommand = "gdformat -l 80 -", formatStdin = true },
			},
		},
	},
})

require("lspconfig").cobol_ls.setup({})

vim.lsp.enable("jsonls")
