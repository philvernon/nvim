return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- 1. Setup capabilities & on_attach handler
			local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
			local on_attach = function(client, bufnr)
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
			end

			-- 2. Setup Mason-registry
			local mason_registry = require("mason-registry")
			mason_registry.refresh()
			mason_registry.update()

			-- 3. Diagnostic configuration
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

			-- 4. Setup mason-lspconfig
			require("mason-lspconfig").setup({
				ensure_installed = { "vue_ls", "ts_ls", "lua_ls", "bashls", "gopls", "marksman" },
			})

			-- 5. Server setups using Neovim native LSP client configurations
			vim.lsp.config("yamlls", {
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
			vim.lsp.enable("yamlls")

			local base_on_attach = vim.lsp.config.eslint.on_attach
			vim.lsp.config("eslint", {
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
				settings = {
					workingDirectories = { mode = "auto" },
					experimental = {
						useFlatConfig = true,
					},
				},
			})
			vim.lsp.enable("eslint")

			vim.lsp.config("lua_ls", {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})
			vim.lsp.enable("lua_ls")

			vim.lsp.config("marksman", {
				on_attach = on_attach,
			})
			vim.lsp.enable("marksman")

			vim.lsp.config("gopls", {
				on_attach = on_attach,
				settings = {
					gopls = {
						buildFlags = { "-tags=configtool" },
					},
				},
			})
			vim.lsp.enable("gopls")

			vim.lsp.config("bashls", {
				on_attach = on_attach,
			})
			vim.lsp.enable("bashls")

			vim.lsp.config("html", {
				capabilities = capabilities,
			})
			vim.lsp.enable("html")

			vim.lsp.config("cssls", {
				capabilities = capabilities,
			})
			vim.lsp.enable("cssls")
			vim.lsp.enable("sqls")
			vim.lsp.enable("efm")
			vim.lsp.enable("jsonls")

			-- Volar & TS Setup
			local vue_language_server_path = vim.fn.expand("$MASON/packages")
				.. "/vue-language-server"
				.. "/node_modules/@vue/language-server"
			local tsserver_filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }
			local vue_plugin = {
				name = "@vue/typescript-plugin",
				location = vue_language_server_path,
				languages = { "vue" },
				configNamespace = "typescript",
			}
			local vtsls_config = {
				settings = {
					vtsls = {
						tsserver = {
							globalPlugins = {
								vue_plugin,
							},
						},
					},
				},
				filetypes = tsserver_filetypes,
			}

			local ts_ls_config = {
				on_attach = function(client, bufnr)
					client.server_capabilities.documentSymbolProvider = false
					vim.api.nvim_create_autocmd("BufEnter", {
						callback = function()
							if vim.bo.filetype == "vue" then
								client.server_capabilities.documentSymbolProvider = false
							else
								client.server_capabilities.documentSymbolProvider = true
							end
						end,
					})
				end,
				init_options = {
					plugins = {
						vue_plugin,
					},
				},
				settings = {
					typescript = {
						tsserver = {
							useSyntaxServer = false,
						},
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayVariableTypeHintsWhenTypeMatchesName = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
				},
				filetypes = tsserver_filetypes,
			}

			local vue_ls_config = {
				settings = {
					editor = {
						reactivityVisualization = true,
						templateInterpolationDecorators = true,
					},
				},
			}

			vim.lsp.config("vtsls", vtsls_config)
			vim.lsp.config("vue_ls", vue_ls_config)
			vim.lsp.config("ts_ls", ts_ls_config)
			vim.lsp.enable({ "vtsls", "vue_ls" })

			-- 6. Setup LSP Keymaps
			local opts = { noremap = true, silent = true }
			local keymap = vim.api.nvim_set_keymap

			keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
			keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
			keymap("n", "<bslash>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
			keymap("n", "<bslash>gl", '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>', opts)
			keymap("n", "<bslash>gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
			keymap("n", "K", "<cmd>lua vim.lsp.buf.hover({ border = 'none' })<CR>", opts)
			keymap("n", "<bslash>k", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
			keymap(
				"n",
				"<bslash>gf",
				"<cmd>lua vim.lsp.buf.format({filter = function(client) return client.name == 'null-ls' end})<CR>",
				opts
			)
			keymap("n", "<leader>dq", "<cmd>lua vim.diagnostic.toqflist()<CR>", opts)
			keymap("n", "<leader>ds", "<cmd>:lua vim.diagnostic.config({ virtual_text = true })<CR>", opts)
			keymap("n", "<leader>dh", "<cmd>:lua vim.diagnostic.config({ virtual_text = false })<CR>", opts)

			_G.toggle_diagnostic = function()
				vim.diagnostic.enable(not vim.diagnostic.is_enabled())
			end
			keymap("n", "<leader>dd", "<cmd>lua toggle_diagnostic()<CR>", opts)
			keymap("n", "<leader>de", "<cmd>lua vim.diagnostic.enable()<CR>", opts)

			keymap("", "<bslash>gn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
			keymap("", "<bslash>ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

			keymap("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded", focusable = true })<CR>', opts)
			keymap("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
		end,
	},
}
