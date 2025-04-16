return {
  {
    'stevearc/oil.nvim',
    config = true,
    init = function()
      vim.keymap.set('n', '<leader>t', function()
        require('oil').toggle_float()
      end)
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
