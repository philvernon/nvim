local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local config = {
  defaults = {
    -- lazy = true
  }
}


require("lazy").setup({
  "nvim-lua/plenary.nvim",
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      {
        -- only needed if you want to use the commands with "_with_window_picker" suffix
        's1n7ax/nvim-window-picker',
        version = "1.*",
        config = function()
          require'window-picker'.setup({
            autoselect_one = true,
            include_current = false,
            filter_rules = {
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { 'neo-tree', "neo-tree-popup", "notify" },

                -- if the buffer type is one of following, the window will be ignored
                buftype = { 'terminal', "quickfix" },
              },
            },
            other_win_hl_color = '#e35e4f',
          })
        end,
      }
    }
  },
  {
    "nvim-telescope/telescope.nvim",
    -- tag = "0.1.0",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
  },
  "benfowler/telescope-luasnip.nvim",
  "nvim-telescope/telescope-project.nvim",
  -- "williamboman/nvim-lsp-installer",
  { "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons"} },

  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  { "neovim/nvim-lspconfig" },
  { "jose-elias-alvarez/null-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { "windwp/nvim-autopairs" },
  -- { 'echasnovski/mini.pairs', version = '*' },
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "hrsh7th/cmp-calc",
  "hrsh7th/nvim-cmp",
  "rafamadriz/friendly-snippets",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  "kylechui/nvim-surround",
  "windwp/nvim-ts-autotag",
  'ThePrimeagen/harpoon',
  "famiu/bufdelete.nvim",
  "lukas-reineke/indent-blankline.nvim",
  "lewis6991/gitsigns.nvim",
  "numToStr/Comment.nvim",
  { "folke/which-key.nvim" },
  "akinsho/toggleterm.nvim",
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons", opt = true } },
  { "catppuccin/nvim", as = "catppuccin" },
  "simrat39/symbols-outline.nvim",
  'norcalli/nvim-colorizer.lua',
  'dkarter/bullets.vim',
  'tpope/vim-fugitive',
  { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },
  ({
    "andrewferrier/debugprint.nvim",
    config = function()
      require("debugprint").setup()
    end,
  }),
  { "weirongxu/plantuml-previewer.vim", lazy = true },
  { "iamcco/markdown-preview.nvim" },
  { 'mfussenegger/nvim-dap', lazy = true },
  { "ellisonleao/glow.nvim" },
  { 'skywind3000/asyncrun.vim'},
  { "tyru/open-browser.vim", lazy = true },
  { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap"}, lazy = true },
  {
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end,
    lazy = true
  },
  "folke/zen-mode.nvim"

}, config)
