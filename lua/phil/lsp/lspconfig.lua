local lspconfig = require 'lspconfig'
local lspconfig_configs = require 'lspconfig.configs'


-- local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- local on_attach = function(client, bufnr)
--   -- Enable completion triggered by <c-x><c-o>
--   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
-- end

-- require("lspconfig").tsserver.setup {
--     root_dir = require 'lspconfig'.util.root_pattern('package.json', 'tsconfig.json'),
--     init_options = {
--         tsserver = {
--             path = "/Users/philipvernon/.nvm/versions/node/v14.18.1/lib/node_modules/typescript-language-server/lib",
--             validate = {
--                 enable = false
--             }
--         }
--     },
--     settings = {
--         completions = {
--             completeFunctionCalls = true
--         }
--     },
--     capabilities = capabilities,
--     on_attach = on_attach
-- }

-- require 'lspconfig'.vuels.setup {
--     capabilities = capabilities,
--     -- on_attach = on_attach,
--     filetypes = { 'javascriptreact', 'typescriptreact', 'vue', 'json' },
--     settings = {
--         vetur = {
--             experimental = {
--                 templateInterpolationService = false
--             },
--             validation = {
--                 template = false,
--                 script = true,
--                 style = true,
--                 templateProps = true,
--                 interpolation = true
--             }
--         }
--     },
-- }

require 'lspconfig'.yamlls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        yaml = {
            format = {
                enable = true
            }
        }
    }

}

require'lspconfig'.volar.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150,
    },
    -- Enable "Take Over Mode" where volar will provide all TS LSP services
    -- This drastically improves the responsiveness of diagnostic updates on change
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
})

require 'lspconfig'.lua_ls.setup {
    on_attach = on_attach,
    root_dir = function(fname)
      local root_pattern = require 'lspconfig'.util.root_pattern('.git', '*.rockspec')(fname)

      if fname == vim.loop.os_homedir() then return nil end
      return root_pattern or fname
    end,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

require 'lspconfig'.marksman.setup {
    on_attach = on_attach
}

require 'lspconfig'.gopls.setup {
    on_attach = on_attach
}

require 'lspconfig'.bashls.setup {
    on_attach = on_attach
}

require'lspconfig'.html.setup {
  capabilities = capabilities,
}

require'lspconfig'.cssls.setup {
  capabilities = capabilities,
}

require'lspconfig'.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"rust"},
})
