vim.keymap.set('n', '<leader>lj',
               '"ayiwoconsole.log(`🚀 ~ <C-R>a:`, <C-R>a)<Esc>')
vim.keymap.set('n', '<leader>ll', '"ayiwodev_log(`<C-R>a:`, <C-R>a)<Esc>')
vim.keymap.set('n', '<leader>ls', '"ayiwostatic_log(`<C-R>a:`, <C-R>a)<Esc>')
vim.keymap.set('n', '<leader>le', '"ayiwolog_error(`<C-R>a:`, <C-R>a)<Esc>')
vim.keymap.set('n', '<leader>ln', '"ayiwonet_error(`<C-R>a:`, <C-R>a)<Esc>')
vim.keymap.set('n', '<leader>d', '<cmd>bd<cr>')
vim.keymap.set('n', '<leader>h', '<C-6>')
vim.keymap.set('v', 'd', '"_d')
vim.keymap.set('n', 'dd', '"_dd')
vim.keymap.set('n', '<leader>c', '<cmd>noh<cr>')
vim.keymap.set({'n', 'v', 'i'}, '<C-W>', '<cmd>q<cr>')

vim.keymap.set("v", "N", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "E", ":m '<-2<CR>gv=gv")

vim.keymap.set({'v', 'n'}, 'rr', '<Plug>RestNvim')
vim.keymap.set({'v', 'n'}, 'rc', '<Plug>RestNvimPreview')

vim.keymap.set('i', '<C-x>', '<C-c>f<lt>vf>x')
vim.keymap.set('n', '<C-x>', 'f<lt>vf>x')

-- treesitter hopper
vim.keymap
    .set({'n', 'x', 'o'}, 'm', function() require'leap-ast'.leap() end, {})

-- vim.keymap.set('n', '<leader>t', '<cmd>RnvimrToggle<CR>')
vim.keymap.set('n', 'J', '0')
vim.keymap.set('n', ';', '$')

vim.keymap.del({'o', 'x'}, 'x')

-- harpoon
vim.keymap.set('n', '<leader>s',
               '<cmd>lua require("harpoon.mark").add_file()<cr>')
vim.keymap
    .set('n', '<leader>.', '<cmd>lua require("harpoon.ui").nav_next()<cr>')
vim.keymap
    .set('n', '<leader>,', '<cmd>lua require("harpoon.ui").nav_prev()<cr>')
vim.keymap.set('n', '<leader>r',
               '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>')
vim.keymap.set('n', '<leader>n',
               '<cmd>lua require("harpoon.term").gotoTerminal(1)<cr>')
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('n', '<leader>1',
               '<cmd>lua require("harpoon.ui").nav_file(1)<cr>')
vim.keymap.set('n', '<leader>2',
               '<cmd>lua require("harpoon.ui").nav_file(2)<cr>')
vim.keymap.set('n', '<leader>3',
               '<cmd>lua require("harpoon.ui").nav_file(3)<cr>')
vim.keymap.set('n', '<leader>4',
               '<cmd>lua require("harpoon.ui").nav_file(4)<cr>')
vim.keymap.set('n', '<leader>5',
               '<cmd>lua require("harpoon.ui").nav_file(5)<cr>')
vim.keymap.set('n', '<leader>6',
               '<cmd>lua require("harpoon.ui").nav_file(6)<cr>')
vim.keymap.set('n', '<leader>7',
               '<cmd>lua require("harpoon.ui").nav_file(7)<cr>')
vim.keymap.set('n', '<leader>8',
               '<cmd>lua require("harpoon.ui").nav_file(8)<cr>')

-- git fugitive
vim.keymap.set('n', '<leader>gs', '<cmd>Git<cr>')
vim.keymap.set('n', '<leader>gc', function()
    vim.cmd('Git add *')
    vim.cmd('Git commit')
end)
vim.keymap.set('n', '<leader>gp', '<cmd>Git push<cr>')

-- git conflict
vim.keymap.set('n', '<leader>mc', '<cmd>GitConflictChooseOurs<CR>')
vim.keymap.set('n', '<leader>mi', '<cmd>GitConflictChooseTheirs<CR>')
vim.keymap.set('n', '<leader>mb', '<cmd>GitConflictChooseBoth<CR>')
vim.keymap.set('n', '<leader>md', '<cmd>GitConflictChooseNone<CR>')
vim.keymap.set('n', '<leader>mn', '<cmd>GitConflictNextConflict<CR>')
vim.keymap.set('n', '<leader>mp', '<cmd>GitConflictPrevConflict<CR>')
