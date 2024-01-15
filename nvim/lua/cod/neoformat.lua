vim.keymap.set("n", '<leader>f', '<cmd>Neoformat<cr>')
vim.g.neoformat_try_node_exe = 1
vim.g.neoformat_enabled_cpp = {"uncrustify"}
vim.g.neoformat_enabled_javascript = {"prettier"}
vim.g.neoformat_enabled_typescript = {"prettier"}
vim.g.neoformat_enabled_typescriptreact = {"prettier"}
vim.api.nvim_create_autocmd('BufWritePre', {command = "Neoformat"})
