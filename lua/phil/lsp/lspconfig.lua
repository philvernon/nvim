local lspconfig = require 'lspconfig'
local lspconfig_configs = require 'lspconfig.configs'
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

vim.diagnostic.config({
    virtual_text = false,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

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

require 'lspconfig'.volar.setup({
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

require 'lspconfig'.html.setup {
  capabilities = capabilities,
}

require 'lspconfig'.cssls.setup {
  capabilities = capabilities,
}

require 'lspconfig'.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "rust" },
  root_dir = lspconfig.util.root_pattern("Cargo.toml"),
  setting = {
    ['rust-analyzer'] = {
      cargo = {
        allFeatures = true
      }
    }
  }
})
