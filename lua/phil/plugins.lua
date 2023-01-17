local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

return packer.startup(function(use)
  use "wbthomason/packer.nvim"
  use "nvim-lua/plenary.nvim"
  use "kyazdani42/nvim-web-devicons"
  -- use { "kyazdani42/nvim-tree.lua", requires = { "kyazdani42/nvim-web-devicons", } }
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  }
  use {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0",
    requires = { { "nvim-lua/plenary.nvim" } },
  }
  use "nvim-telescope/telescope-file-browser.nvim"
  use "benfowler/telescope-luasnip.nvim"
  use "williamboman/nvim-lsp-installer"
  use { "neovim/nvim-lspconfig" }
  use { "jose-elias-alvarez/null-ls.nvim", config = function() require("null-ls").setup() end, requires = { "nvim-lua/plenary.nvim" } }
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp-signature-help"
  use "rafamadriz/friendly-snippets"
  use "L3MON4D3/LuaSnip"
  use "saadparwaiz1/cmp_luasnip"
  use "kylechui/nvim-surround"
  use "windwp/nvim-autopairs"
  use "windwp/nvim-ts-autotag"
  use { "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" }
  use "famiu/bufdelete.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use "lewis6991/gitsigns.nvim"
  use "numToStr/Comment.nvim"
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use { "nvim-treesitter/nvim-treesitter", tag="4cccb6f494eb255b32a290d37c35ca12584c74d0", run = function() require("nvim-treesitter.install").update({ with_sync = true }) end, }
  use { "folke/which-key.nvim" }
  use { "akinsho/toggleterm.nvim", tag = "*" }
  use 'voldikss/vim-floaterm'
  use 'skywind3000/asyncrun.vim'
  use { "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true }, }
  use 'rebelot/heirline.nvim'
  use "EdenEast/nightfox.nvim"
  use "rebelot/kanagawa.nvim"
  use { "catppuccin/nvim", as = "catppuccin" }
  use "LunarVim/onedarker.nvim"
  use "tyru/open-browser.vim"
  use "weirongxu/plantuml-previewer.vim"
  use "ellisonleao/glow.nvim"
  use "iamcco/markdown-preview.nvim"
  use "dstein64/vim-startuptime"
  use "simrat39/symbols-outline.nvim"
  use 'Mofiqul/dracula.nvim'
  use({
    "andrewferrier/debugprint.nvim",
    config = function()
      require("debugprint").setup()
    end,
  })

  use {
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end 
  }

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
