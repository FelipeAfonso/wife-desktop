vim.wo.number = true
vim.opt.encoding = 'UTF-8'
vim.g.mapleader = ' '
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.hlsearch = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.guicursor = 'n-v-c-sm:block,i-ci-ve:hor20-Cursor-blinkwait300-blinkon200-blinkoff150,r-cr-o:hor20'
vim.opt.relativenumber = true
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = '~/.vim/undodir'
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.colorcolumn = '100'
vim.opt.signcolumn = 'yes'
vim.opt.scrolloff = 8
vim.opt.path:append { '**' }
vim.opt.wildignore:append { '*/node_modules/', '*/.next/*' }
vim.opt.clipboard:append { 'unnamedplus' }
vim.opt.undofile = false
vim.opt.termguicolors = true
vim.opt.titlestring = string.match(vim.fn.getcwd(), "^.+/(.+)$")
vim.opt.wrap = true
vim.opt.mouse = ''
