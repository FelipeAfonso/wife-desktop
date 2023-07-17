require('carbon').setup()
vim.keymap.set('n', '<leader>q', function ()
    require('carbon.view').close_float()
end)

