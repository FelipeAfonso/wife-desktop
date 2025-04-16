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
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
      vim.cmd.colorscheme 'tokyonight-night'
      vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
      -- vim.api.nvim_create_autocmd('BufEnter', {
      --   callback = function(args)
      -- local file = args.file
      -- local ft = file:match '^.+%.(.+)$'
      -- if ft == 'svelte' then
      --   vim.cmd.colorscheme 'spaceduck'
      -- elseif ft == 'ts' then
      --   vim.cmd.colorscheme 'tokyonight-night'
      -- elseif ft == 'go' then
      --   vim.cmd.colorscheme 'aura-soft-dark-soft-text'
      -- elseif ft == 'gleam' then
      --   vim.cmd.colorscheme 'catppuccin-mocha'
      -- elseif ft == 'html' then
      --   vim.cmd.colorscheme 'eldritch'
      -- elseif ft == 'lua' then
      --   vim.cmd.colorscheme 'kanagawa'
      -- elseif ft == 'rs' then
      --   vim.cmd.colorscheme 'rose-pine-main'
      -- elseif ft == 'env' then
      --   vim.cmd.colorscheme 'lackluster'
      -- else
      --   vim.cmd.colorscheme 'tokyonight-night'
      -- end
      -- vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
      --   end,
      -- })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
