local binder = require('keymap')
local nnoremap = binder.nnoremap
local vnoremap = binder.vnoremap
local inoremap = binder.inoremap
local nmap = binder.nmap

nnoremap('<leader>pp', '<cmd>Telescope find_files<cr>')
nnoremap('<leader>pf', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
nnoremap('<leader>l', '"ayiwoconsole.log(`🚀 ~ <C-R>a:`, <C-R>a)<Esc>')
nnoremap('<leader>tt', '<cmd>NERDTreeToggle<cr>')
nnoremap('<leader>tf', '<cmd>NERDTreeFocus<cr>')
nnoremap('<leader>,', '<cmd>bp<cr>')
nnoremap('<leader>.', '<cmd>bn<cr>')
nnoremap('<leader>d', '<cmd>bd<cr>')
nnoremap('<leader>o', '<cmd>OrganizeImports<cr>')
nnoremap('<C-x>', 'yydd')
nnoremap('d', '"_d')
nnoremap('<C-d>', '<C-d>zz')
nnoremap('<C-u>', '<C-u>zz')

nmap('<leader>1', '<Plug>lightline#bufferline#go(1)')
nmap('<leader>2', '<Plug>lightline#bufferline#go(2)')
nmap('<leader>3', '<Plug>lightline#bufferline#go(3)')
nmap('<leader>4', '<Plug>lightline#bufferline#go(4)')
nmap('<leader>5', '<Plug>lightline#bufferline#go(5)')
nmap('<leader>6', '<Plug>lightline#bufferline#go(6)')
nmap('<leader>7', '<Plug>lightline#bufferline#go(7)')
nmap('<leader>8', '<Plug>lightline#bufferline#go(8)')
nmap('<leader>9', '<Plug>lightline#bufferline#go(9)')
nmap('<leader>0', '<Plug>lightline#bufferline#go(10)')

vnoremap('d', '"_d')
inoremap('<C-x>', '<C-c>f<lt>vf>x')
