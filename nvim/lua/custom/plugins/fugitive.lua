return {
  {
    'tpope/vim-fugitive',
    init = function()
      vim.keymap.set('n', '<leader>gc', function()
        vim.cmd 'Git add *'
        vim.cmd 'Git commit'
      end)
      vim.keymap.set('n', '<leader>gp', '<cmd>Git push<cr>')
      vim.keymap.set('n', '<leader>gb', '<cmd>Gitsigns toggle_current_line_blame<cr>')
    end,
  },
}
