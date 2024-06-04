-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-l>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-y>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-n>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-e>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.keymap.set('n', '<leader>ll', '"ayiwoconsole.log(`🚀 ~ <C-R>a:`, <C-R>a)<Esc>')
vim.keymap.set('n', '<leader>ld', '"ayiwodev_log(`<C-R>a:`, <C-R>a)<Esc>')
vim.keymap.set('n', '<leader>ls', '"ayiwostatic_log(`<C-R>a:`, <C-R>a)<Esc>')
vim.keymap.set('n', '<leader>le', '"ayiwolog_error(`<C-R>a:`, <C-R>a)<Esc>')
vim.keymap.set('n', '<leader>ln', '"ayiwonet_error(`<C-R>a:`, <C-R>a)<Esc>')
vim.keymap.set('n', '<leader>d', '<cmd>bd<cr>')
vim.keymap.set('n', '<leader>h', '<C-6>')
vim.keymap.set('v', 'd', '"_d')
vim.keymap.set('n', 'dd', '"_dd')
vim.keymap.set('n', '<leader>c', '<cmd>noh<cr>')
vim.keymap.set('n', '<C-s>', '<C-W>')
vim.keymap.set({ 'n', 'v' }, '<C-W>', '<cmd>q<cr>')
vim.keymap.set({ 'n', 'v', 'x', 'o' }, '<C-i>', '<C-a>')
vim.keymap.set({ 'n', 'v' }, 'g<C-i>', 'g<C-a>')

vim.keymap.set('v', 'N', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'E', ":m '<-2<CR>gv=gv")

vim.keymap.set('i', '<C-x>', '<C-c>f<lt>vf>x')
vim.keymap.set('n', '<C-x>', 'f<lt>vf>x')

vim.keymap.set({ 'n', 'v' }, 'J', '0')
vim.keymap.set({ 'n', 'v' }, ';', '$')

-- colemak remap
vim.keymap.set({ 'n', 'v', 'x', 'o' }, 'h', 'k')
vim.keymap.set({ 'n', 'v', 'x', 'o' }, 'k', 'j')
vim.keymap.set({ 'n', 'v', 'x', 'o' }, 'j', 'h')

vim.keymap.set('n', '<C-T>', function()
  vim.cmd 'LspRestart'
  vim.cmd 'LspStart'
end)

vim.keymap.del('n', '<C-W><C-D>')
vim.keymap.del('n', '<C-W>d')
