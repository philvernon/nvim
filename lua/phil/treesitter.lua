require'nvim-treesitter.configs'.setup {
    ensure_installed = { "norg" },
    highlight = { 
        enable = true,
    },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  }
}
