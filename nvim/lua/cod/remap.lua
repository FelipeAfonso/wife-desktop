vim.keymap.set('n', '<leader>l', '"ayiwoconsole.log(`🚀 ~ <C-R>a:`, <C-R>a)<Esc>')
vim.keymap.set('n', '<leader>d', '<cmd>bd<cr>')
vim.keymap.set('n', '<leader>h', '<C-6>')
vim.keymap.set({'n', 'v'}, 'R','<cmd>Sad<cr>')

vim.keymap.set('n', '<C-w>', '<cmd>q<cr>')
vim.keymap.set('i', '<C-x>', '<C-c>f<lt>vf>x')
vim.keymap.set('n', '<C-x>', 'f<lt>vf>x')

vim.keymap.set('n', '<leader>t', '<cmd>RnvimrToggle<CR>')

-- harpoon
vim.keymap.set('n', '<leader>s', '<cmd>lua require("harpoon.mark").add_file()<cr>')
vim.keymap.set('n', '<leader>.', '<cmd>lua require("harpoon.ui").nav_next()<cr>')
vim.keymap.set('n', '<leader>,', '<cmd>lua require("harpoon.ui").nav_prev()<cr>')
vim.keymap.set('n', '<leader>r', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>')
vim.keymap.set('n', '<leader>n', '<cmd>lua require("harpoon.term").gotoTerminal(1)<cr>')
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('n', '<leader>1', '<cmd>lua require("harpoon.ui").nav_file(1)<cr>')
vim.keymap.set('n', '<leader>2', '<cmd>lua require("harpoon.ui").nav_file(2)<cr>')
vim.keymap.set('n', '<leader>3', '<cmd>lua require("harpoon.ui").nav_file(3)<cr>')
vim.keymap.set('n', '<leader>4', '<cmd>lua require("harpoon.ui").nav_file(4)<cr>')
vim.keymap.set('n', '<leader>5', '<cmd>lua require("harpoon.ui").nav_file(5)<cr>')
vim.keymap.set('n', '<leader>6', '<cmd>lua require("harpoon.ui").nav_file(6)<cr>')
vim.keymap.set('n', '<leader>7', '<cmd>lua require("harpoon.ui").nav_file(7)<cr>')
vim.keymap.set('n', '<leader>8', '<cmd>lua require("harpoon.ui").nav_file(8)<cr>')

-- git fugitive
vim.keymap.set('n', '<leader>gs', '<cmd>Git<cr>')
vim.keymap.set('n', '<leader>gc', function ()
    vim.cmd('Git add *')
    vim.cmd('Git commit')
end)
vim.keymap.set('n', '<leader>gp', '<cmd>Git push<cr>')

-- git conflict
vim.keymap.set('n', '<leader>mc','<cmd>GitConflictChooseOurs<CR>')
vim.keymap.set('n', '<leader>mi','<cmd>GitConflictChooseTheirs<CR>')
vim.keymap.set('n', '<leader>mb','<cmd>GitConflictChooseBoth<CR>')
vim.keymap.set('n', '<leader>md','<cmd>GitConflictChooseNone<CR>')
vim.keymap.set('n', '<leader>mn','<cmd>GitConflictNextConflict<CR>')
vim.keymap.set('n', '<leader>mp','<cmd>GitConflictPrevConflict<CR>')

-- avoiding colemak conflicts
vim.keymap.del({'n','x'}, '<c-w>m')
vim.keymap.del({'n','x'}, '<c-w>n')
vim.keymap.del({'n','x'}, '<c-w>e')
vim.keymap.del({'n','x'}, '<c-w>i')


-- fix for fugitive/colemak colision
vim.api.nvim_create_autocmd('User FugitiveObject', {
    callback = function ()
        if vim.fn.maparg('y<C-G>', 'n') == ':<C-U>call setreg(v:register, fugitive#Object(@%))<CR>' then
            vim.keymap.del('n', 'y<C-G>')
        end
    end
})

