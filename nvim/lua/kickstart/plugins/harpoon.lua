return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    commit = 'e76cb03',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = false,
    config = function()
      local harpoon = require 'harpoon'

      harpoon:setup { settings = { sync_on_ui_close = true, save_on_toggle = true } }

      vim.keymap.set('n', '<leader>s', function()
        harpoon:list():add()
      end)
      vim.keymap.set('n', '<leader>r', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)
      vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
      vim.keymap.set('n', '<leader>1', function()
        harpoon:list():select(1)
      end)
      vim.keymap.set('n', '<leader>2', function()
        harpoon:list():select(2)
      end)
      vim.keymap.set('n', '<leader>3', function()
        harpoon:list():select(3)
      end)
      vim.keymap.set('n', '<leader>4', function()
        harpoon:list():select(4)
      end)
      vim.keymap.set('n', '<leader>5', function()
        harpoon:list():select(5)
      end)
      vim.keymap.set('n', '<leader>6', function()
        harpoon:list():select(6)
      end)
      vim.keymap.set('n', '<leader>7', function()
        harpoon:list():select(7)
      end)
      vim.keymap.set('n', '<leader>8', function()
        harpoon:list():select(8)
      end)
    end,
  },
}
