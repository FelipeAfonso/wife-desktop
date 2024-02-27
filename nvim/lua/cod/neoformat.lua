vim.keymap.set("n", '<leader>f', '<cmd>Neoformat<cr>')
vim.g.neoformat_try_node_exe = 1
vim.api.nvim_create_autocmd('BufWritePre', {
    command = "Neoformat"
})
