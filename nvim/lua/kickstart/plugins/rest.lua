return {
  {
    'vhyrro/luarocks.nvim',
    priority = 1000,
    config = function()
      require('luarocks-nvim').setup()
    end,
    opts = {
      rocks = { 'mimetypes', 'xml2lua' },
    },
  },
  -- {
  --   'rest-nvim/rest.nvim',
  --   ft = 'http',
  --   dependencies = { 'luarocks.nvim' },
  --   config = function()
  --     require('rest-nvim').setup()
  --     vim.keymap.set('v', '<C-t>r', '<cmd>Rest run<cr>')
  --     vim.keymap.set('n', '<C-t>r', '<cmd>Rest run<cr>')
  --   end,
  -- },
  {
    'rest-nvim/rest.nvim',
    -- dependencies = { 'nvim-neorocks/rocks.nvim' },
    config = function()
      vim.keymap.set({ 'n', 'v' }, '<c-t>r', '<cmd>Rest run<cr>')
    end,
  },
}
