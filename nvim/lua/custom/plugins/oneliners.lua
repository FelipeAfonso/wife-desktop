return {
  'mg979/vim-visual-multi',
  'JoosepAlviste/nvim-ts-context-commentstring',
  { 'NvChad/nvim-colorizer.lua', config = true },
  { 'nvchad/volt', lazy = true },
  {
    'nvchad/minty',
    cmd = { 'Shades', 'Huefy' },
  },
  {
    -- fuck this guy
    -- |
    -- |
    -- V
    'max397574/better-escape.nvim',
    config = true,
    opts = {
      default_mappings = false,
      timeout = 200,
      mappings = {
        i = {
          n = {
            -- These can all also be functions
            n = '<Esc>',
          },
        },
      },
    },
  },
}
