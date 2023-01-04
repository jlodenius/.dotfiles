-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

return packer.startup(function(use)
  -- packer manages itself
  use("wbthomason/packer.nvim")

  use("nvim-lua/plenary.nvim") -- dependency to other plugins

  use({ "rose-pine/neovim", as = "rose-pine" }) -- colour scheme

  use("szw/vim-maximizer") -- maximizes and restores current window

  use("numToStr/Comment.nvim") -- commenting with gc command

  -- to comment jsx/tsx with comment plugin
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use("nvim-tree/nvim-tree.lua") -- file explorer

  use("kyazdani42/nvim-web-devicons") -- file icons

  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
  use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder

  -- autocompletion
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")

  -- snippets
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")
  use("rafamadriz/friendly-snippets")

  -- LSP
  use("williamboman/mason.nvim") -- managing and installing lsp servers
  use("williamboman/mason-lspconfig")

  -- configuring lsp servers
  use("neovim/nvim-lspconfig")
  use("hrsh7th/cmp-nvim-lsp") -- to make lsp appear in auto completion
  use({ "glepnir/lspsaga.nvim", branch = "main" }) -- some visual stuff
  use("onsails/lspkind.nvim") -- icons to auto complete window
  use("jose-elias-alvarez/typescript.nvim") -- improves typescript lsp

  -- formatting & linting
  use("jose-elias-alvarez/null-ls.nvim")
  use("jayp0521/mason-null-ls.nvim")

  -- treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
  })

  -- auto closing
  use("windwp/nvim-autopairs")
  use("windwp/nvim-ts-autotag")

  -- status bar
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  })

  -- git
  use("lewis6991/gitsigns.nvim")
  use("tpope/vim-fugitive")

  if packer_bootstrap then
    require("packer").sync()
  end
end)
