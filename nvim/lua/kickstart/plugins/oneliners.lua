return {
  'mg979/vim-visual-multi',
  { 'NvChad/nvim-colorizer.lua', config = true },
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
