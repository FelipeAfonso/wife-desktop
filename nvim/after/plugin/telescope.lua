local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pa', builtin.find_files, {})
vim.keymap.set('n', '<leader>pf', builtin.live_grep, {})
vim.keymap.set('n', '<leader>pp', builtin.git_files, {})
vim.keymap.set('n', '<leader>pp', builtin.git_files, {})


-- lsp.setup_servers({'tsserver', 'eslint'})
