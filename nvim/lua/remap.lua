local binder = require('keymap')
local nnoremap = binder.nnoremap
local inoremap = binder.inoremap

nnoremap('<leader>op', '<cmd>Ex<CR>')
nnoremap('<leader>p', '<cmd>Telescope find_files<cr>')
nnoremap('<leader>l', '"ayiwoconsole.log(`🚀 ~ <C-R>a:`, <C-R>a)<Esc>')
nnoremap('<leader>t', '<cmd>NERDTreeToggle<cr>')

