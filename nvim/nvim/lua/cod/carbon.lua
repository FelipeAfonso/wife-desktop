require('carbon').setup({
    bang = true
})

vim.keymap.set("n", "<leader>t", '<cmd>Fcarbon<cr>')
vim.keymap.set("n", "<leader>c", '<cmd>Fcarbon!<cr>')
vim.keymap.set('n', '<leader>q', function ()
        require('carbon.view').close_float()
end)
