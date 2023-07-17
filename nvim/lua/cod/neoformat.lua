vim.keymap.set("n", '<leader>f', '<cmd>Neoformat<cr>')
vim.api.nvim_create_autocmd('BufWritePre', {
    command = "Neoformat"
})
