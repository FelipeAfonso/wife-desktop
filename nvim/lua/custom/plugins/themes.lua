return {
  'rebelot/kanagawa.nvim',
  'catppuccin/nvim',
  'talha-akram/noctis.nvim',
  'pineapplegiant/spaceduck',
  'slugbyte/lackluster.nvim',
  {
    'baliestri/aura-theme',
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. '/packages/neovim')
    end,
  },
  'doums/darcula',
  'frenzyexists/aquarium-vim',
  { 'kepano/flexoki-neovim', name = 'flexoki' },
  'rose-pine/neovim',
  'nyoom-engineering/oxocarbon.nvim',
  'bluz71/vim-moonfly-colors',
  'eldritch-theme/eldritch.nvim',
  'folke/tokyonight.nvim',
  {
    'RedsXDD/neopywal.nvim',
    name = 'neopywal',
    lazy = false,
    priority = 1000,
    opts = {
      -- Use wallust-generated colors from ~/.cache/wallust/colors_neopywal.vim
      use_wallust = true,

      -- Transparent background (matches ghostty opacity)
      transparent_background = true,

      -- Dim inactive windows for better focus
      dim_inactive = true,

      -- Terminal colors from wallust palette
      terminal_colors = true,

      -- Plugin integrations
      default_plugins = true,
      plugins = {
        telescope = true,
        gitsigns = true,
        indent_blankline = true,
        lazy = true,
        nvim_cmp = true,
        treesitter = true,
        flash = { enabled = true, style = { 'bold', 'italic' } },
        leap = { enabled = true, style = { 'bold', 'italic' } },
        mini = {
          cursorword = true,
          files = true,
          pick = true,
        },
      },
    },
    init = function()
      vim.cmd.colorscheme 'neopywal'
      vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
