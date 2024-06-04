return {
  {
    'stevearc/oil.nvim',
    config = true,
    init = function()
      vim.keymap.set('n', '<leader>t', '<cmd>Oil<cr>')
    end,
    opts = {
      keymap = {
        ['<CR>'] = 'actions.select',
        ['<C-p>'] = 'actions.preview',
        ['<C-l>'] = 'actions.refresh',
        ['Q'] = 'actions.close',
        ['-'] = 'actions.parent',
        ['g.'] = 'actions.toggle_hidden',
      },
      view_options = {
        show_hidden = true,
      },
    },
  },
}
