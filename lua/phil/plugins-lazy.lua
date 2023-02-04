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



require("lazy").setup({


  "wbthomason/packer.nvim",
  "nvim-lua/plenary.nvim",
  "kyazdani42/nvim-web-devicons",
  "nvim-treesitter/nvim-treesitter",
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      {
        -- only needed if you want to use the commands with "_with_window_picker" suffix
        's1n7ax/nvim-window-picker',
        tag = "v1.*",
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
    dependencies = { { "nvim-lua/plenary.nvim" } },
  },
  "nvim-telescope/telescope-file-browser.nvim",
  "benfowler/telescope-luasnip.nvim",
  "williamboman/nvim-lsp-installer",
  { "neovim/nvim-lspconfig" },
  { "jose-elias-alvarez/null-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  "windwp/nvim-autopairs",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "rafamadriz/friendly-snippets",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  "kylechui/nvim-surround",
  "windwp/nvim-ts-autotag",
  'ThePrimeagen/harpoon',
  --{ "akinsho/bufferline.nvim", tag = "v3.1.0", dependencies = "kyazdani42/nvim-web-devicons" },
  -- {'romgrk/barbar.nvim', wants = 'nvim-web-devicons'},
  -- 'nanozuki/tabby.nvim',
  "famiu/bufdelete.nvim",
  "lukas-reineke/indent-blankline.nvim",
  "lewis6991/gitsigns.nvim",
  "numToStr/Comment.nvim",
  "JoosepAlviste/nvim-ts-context-commentstring",
  { "folke/which-key.nvim" },
  "akinsho/toggleterm.nvim",
  'voldikss/vim-floaterm',
  'skywind3000/asyncrun.vim',
  { "nvim-lualine/lualine.nvim", dependencies = { "kyazdani42/nvim-web-devicons", opt = true } },
  'rebelot/heirline.nvim',
  "EdenEast/nightfox.nvim",
  "rebelot/kanagawa.nvim",
  { "catppuccin/nvim", as = "catppuccin" },
  "LunarVim/onedarker.nvim",
  "tyru/open-browser.vim",
  "weirongxu/plantuml-previewer.vim",
  "ellisonleao/glow.nvim",
  "iamcco/markdown-preview.nvim",
  "dstein64/vim-startuptime",
  "simrat39/symbols-outline.nvim",
  'Mofiqul/dracula.nvim',
  'norcalli/nvim-colorizer.lua',
  'mfussenegger/nvim-dap',
  { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap"} },
  ({
    "andrewferrier/debugprint.nvim",
    config = function()
      require("debugprint").setup()
    end,
  }),

  {
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end
  },

})
