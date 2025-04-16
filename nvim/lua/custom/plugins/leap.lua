return {
  {
    'ggandor/leap.nvim',
    config = function()
      vim.keymap.set({ 'n', 'x', 'o' }, 'ss', '<Plug>(leap-forward)')
      vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-backward)')
      vim.keymap.set({ 'n', 'x', 'o' }, 'gs', '<Plug>(leap-from-window)')
      vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
    end,
    dependencies = {
      'tpope/vim-repeat',
    },
  },
}
