return {
  {
    'aserowy/tmux.nvim',
    config = function(_, opts)
      require('tmux').setup(opts)
      vim.keymap.set('n', '<C-n>', '<cmd>lua require("tmux").move_bottom()<cr>')
      vim.keymap.set('n', '<C-e>', '<cmd>lua require("tmux").move_top()<cr>')
      vim.keymap.set('n', '<C-l>', '<cmd>lua require("tmux").move_left()<cr>')
      vim.keymap.set('n', '<C-y>', '<cmd>lua require("tmux").move_right()<cr>')
      vim.keymap.set('n', '<M-n>', '<cmd>lua require("tmux").resize_bottom()<cr>')
      vim.keymap.set('n', '<M-e>', '<cmd>lua require("tmux").resize_top()<cr>')
      vim.keymap.set('n', '<M-l>', '<cmd>lua require("tmux").resize_left()<cr>')
      vim.keymap.set('n', '<M-y>', '<cmd>lua require("tmux").resize_right()<cr>')
    end,
    opts = {
      navigation = { enable_default_keybindings = false },
      copy_sync = { enable = false },
      resize = { enable_default_keybindings = false },
    },
  },
}
