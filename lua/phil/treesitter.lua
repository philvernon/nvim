require'nvim-treesitter.configs'.setup {
  ensure_installed = { "javascript", "css", "html", "scss", "vue", "typescript", "json", "bash", "lua", "vim", "help" },
  highlight = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<TAB>',
      node_decremental = '<S-TAB>',
    }
  },
  autotag = {
    enable = true,
    filetypes = {
      "html",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "svelte",
      "vue",
      "markdown",
    },
  },
}
