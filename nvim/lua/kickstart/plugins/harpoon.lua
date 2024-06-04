return {
  {
    'ThePrimeagen/harpoon',
    lazy = false,
    config = true,
    init = function()
      vim.keymap.set('n', '<leader>s', '<cmd>lua require("harpoon.mark").add_file()<cr>')
      vim.keymap.set('n', '<leader>r', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>')
      vim.keymap.set('n', '<leader>n', '<cmd>lua require("harpoon.term").gotoTerminal(1)<cr>')
      vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
      vim.keymap.set('n', '<leader>1', '<cmd>lua require("harpoon.ui").nav_file(1)<cr>')
      vim.keymap.set('n', '<leader>2', '<cmd>lua require("harpoon.ui").nav_file(2)<cr>')
      vim.keymap.set('n', '<leader>3', '<cmd>lua require("harpoon.ui").nav_file(3)<cr>')
      vim.keymap.set('n', '<leader>4', '<cmd>lua require("harpoon.ui").nav_file(4)<cr>')
      vim.keymap.set('n', '<leader>5', '<cmd>lua require("harpoon.ui").nav_file(5)<cr>')
      vim.keymap.set('n', '<leader>6', '<cmd>lua require("harpoon.ui").nav_file(6)<cr>')
      vim.keymap.set('n', '<leader>7', '<cmd>lua require("harpoon.ui").nav_file(7)<cr>')
      vim.keymap.set('n', '<leader>8', '<cmd>lua require("harpoon.ui").nav_file(8)<cr>')
    end,
  },
}
