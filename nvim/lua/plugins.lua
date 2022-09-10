-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'bluz71/vim-nightfly-guicolors'
  use 'Julpikar/night-owl.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'norcalli/nvim-colorizer.lua'
  use 'MunifTanjim/prettier.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'
  use { 'neoclide/coc.nvim', 
        branch = 'release' }
  use { 'nvim-telescope/telescope.nvim', 
        tag = '0.1.0', 
        requires = { { 'nvim-lua/plenary.nvim' } }}
  use 'psliwka/vim-smoothie'
  use 'preservim/nerdtree'
  use 'Xuyuanp/nerdtree-git-plugin'
  use 'lewis6991/gitsigns.nvim'
  use {
    "windwp/nvim-autopairs",
      config = function() require("nvim-autopairs").setup {} end
  }
  use 'windwp/nvim-ts-autotag'
  use 'ryanoasis/vim-devicons'
end)
