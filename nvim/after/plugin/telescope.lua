local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pa', builtin.find_files, { })
vim.keymap.set('n', '<leader>pf', builtin.live_grep, {})
vim.keymap.set('n', '<leader>pp', builtin.git_files, {})
vim.keymap.set('n', '<leader>pgb', builtin.git_branches, {})
vim.keymap.set('n', '<leader>pgs', builtin.git_status, {})
vim.keymap.set('n', '<leader>pgc', builtin.git_commits, {})


-- lsp.setup_servers({'tsserver', 'eslint'})
