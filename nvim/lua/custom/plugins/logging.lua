return {
  'Goose97/timber.nvim',
  version = '*', -- Use for stability; omit to use `main` branch for the latest features
  event = 'VeryLazy',
  config = function()
    require('timber').setup {
      keymaps = {
        insert_log_below = '<leader>ll',
        insert_log_above = '<leader>la',
        insert_plain_log_below = '<leader>lpl',
        insert_plain_log_above = '<leader>lpa',
        insert_batch_log = '<leader>lbl',
        add_log_targets_to_batch = '<leader>lba',
        insert_log_below_operator = false,
        insert_log_above_operator = false,
        insert_batch_log_operator = false,
        add_log_targets_to_batch_operator = false,
      },
    }
  end,
}
