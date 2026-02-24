require('lazy').setup({
  -- 'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically

  -- require 'custom/plugins/ai',
  -- require 'custom/plugins/copilot',
  require 'custom/plugins/bevy',
  require 'custom/plugins/early-retirement',
  require 'custom/plugins/fugitive',
  require 'custom/plugins/harpoon',
  require 'custom/plugins/leap',
  require 'custom/plugins/logging',
  require 'custom/plugins/love2d',
  require 'custom/plugins/neotest',
  require 'custom/plugins/oil',
  require 'custom/plugins/oneliners',
  require 'custom/plugins/peek',
  require 'custom/plugins/qf',
  require 'custom/plugins/qf',
  require 'custom/plugins/quickfix',
  require 'custom/plugins/repl',
  require 'custom/plugins/svelte-inspector',
  require 'custom/plugins/themes',
  require 'custom/plugins/tmux',
  require 'custom/plugins/trouble',
  require 'custom/plugins/undotree',
  require 'custom/plugins/yanky',

  require 'kickstart/plugins/autopairs',
  require 'kickstart/plugins/cmp',
  require 'kickstart/plugins/conform',
  require 'kickstart/plugins/gitsigns',
  require 'kickstart/plugins/lint',
  require 'kickstart/plugins/lspconfig',
  require 'kickstart/plugins/mini',
  require 'kickstart/plugins/telescope',
  require 'kickstart/plugins/todo-comments',
  require 'kickstart/plugins/treesitter',
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
