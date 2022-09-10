local binder = require('keymap')
local nnoremap = binder.nnoremap
local inoremap = binder.inoremap

nnoremap('<leader>op', '<cmd>Ex<CR>')
nnoremap('<leader>p', '<cmd>Telescope find_files<cr>')
nnoremap('<leader>l', '"ayiwoconsole.log(`🚀 ~ <C-R>a:`, <C-R>a)<Esc>')
nnoremap('<leader>t', '<cmd>NERDTreeToggle<cr>')
nnoremap('<leader>f', '<Plug>(prettier-format)')
nnoremap('<leader>,', '<cmd>bp<cr>')
nnoremap('<leader>.', '<cmd>bn<cr>')
nnoremap('<leader>d', '<cmd>bd<cr>')
