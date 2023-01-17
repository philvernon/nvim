local lspconfig = require'lspconfig'
local lspconfig_configs = require'lspconfig.configs'
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require("lspconfig").tsserver.setup({
    on_attach = on_attach,
})

require'lspconfig'.vuels.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
    settings = {
        vetur = {
            experimental = {
                templateInterpolationService = false
            },
            validation = {
                template = false,
                script = true,
                style = true,
                templateProps = true,
                interpolation = true
            }
        }
    },
}

-- require'lspconfig'.volar.setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
--     flags = {
--         debounce_text_changes = 150,
--     },
--     -- Enable "Take Over Mode" where volar will provide all TS LSP services
--     -- This drastically improves the responsiveness of diagnostic updates on change
--     filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
-- })

require'lspconfig'.sumneko_lua.setup {
    on_attach = on_attach,
    root_dir = function(fname)
        local root_pattern = require'lspconfig'.util.root_pattern('.git', '*.rockspec')(fname)

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
                globals = {'vim'},
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

require'lspconfig'.marksman.setup{
    on_attach = on_attach
}

require'lspconfig'.bashls.setup{
  on_attach = on_attach
}


