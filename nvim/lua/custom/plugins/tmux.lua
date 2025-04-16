return {
  {
    'aserowy/tmux.nvim',
    config = function(_, opts)
      require('tmux').setup(opts)
      vim.keymap.set('n', '<C-n>', '<cmd>lua require("tmux").move_bottom()<cr>')
      vim.keymap.set('n', '<C-e>', '<cmd>lua require("tmux").move_top()<cr>')
      vim.keymap.set('n', '<C-m>', '<cmd>lua require("tmux").move_left()<cr>')
      vim.keymap.set('n', '<C-i>', '<cmd>lua require("tmux").move_right()<cr>')
      vim.keymap.set('n', '<M-n>', '<cmd>lua require("tmux").resize_bottom()<cr>')
      vim.keymap.set('n', '<M-e>', '<cmd>lua require("tmux").resize_top()<cr>')
      vim.keymap.set('n', '<M-m>', '<cmd>lua require("tmux").resize_left()<cr>')
      vim.keymap.set('n', '<M-i>', '<cmd>lua require("tmux").resize_right()<cr>')
    end,
    opts = {
      navigation = { enable_default_keybindings = false },
      copy_sync = { enable = false },
      resize = { enable_default_keybindings = false },
    },
  },
}
