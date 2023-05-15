require("zen-mode").setup {
  window = {
    height = 1,
    options = {
      signcolumn = "no",
      cursorline = false,
      cursorcolumn = false, -- disable cursor column
      number = false,
      relativenumber = false
    }
  },
  plugins = {
    options = {
      enabled = true,
      showmode = false,
      showcmd = false
    },
    tmux = {
      enabled = true
    }
  },
  on_open = function()
    vim.diagnostic.disable()
  end,
  on_close = function()
    vim.diagnostic.enable()
  end
}
