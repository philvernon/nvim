require'lspconfig'.tsserver.setup{
    on_attach = on_attach,
}

require'lspconfig'.vuels.setup{
    on_attach = on_attach,
    settings = {
        ["vetur.validation.template"] = false
    }
}

require'lspconfig'.sumneko_lua.setup{
    on_attach = on_attach
}

require'lspconfig'.marksman.setup{
    on_attach = on_attach
}
