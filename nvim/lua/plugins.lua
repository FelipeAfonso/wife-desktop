-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'Julpikar/night-owl.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use { 'nvim-telescope/telescope.nvim', 
        tag = '0.1.0', 
        requires = { { 'nvim-lua/plenary.nvim' } }}
  use 'psliwka/vim-smoothie'
  use 'preservim/nerdtree'
  use 'Xuyuanp/nerdtree-git-plugin'
  use 'ryanoasis/vim-devicons'
end)
