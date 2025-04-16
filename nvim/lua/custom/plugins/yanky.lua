return {
  {
    'gbprod/yanky.nvim',
    config = true,
    init = function()
      vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)')
      vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')
      vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')
      vim.keymap.set({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)')
      vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')

      vim.keymap.set('n', '[[', '<Plug>(YankyPreviousEntry)')
      vim.keymap.set('n', ']]', '<Plug>(YankyNextEntry)')
    end,
    opts = {
      system_clipboard = {
        sync_with_ring = true,
      },
      highlight = {
        on_yank = false,
        on_paste = false,
        timer = 0,
      },
    },
  },
}
