return {
  {
    'zbirenbaum/copilot.lua',
    config = true,
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = false,
        debounce = 50,
        keymap = {
          accept = '<C-f>',
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<C-]>',
        },
      },
      filetypes = {
        yaml = true,
        ['.'] = false,
      },
    },
  },
}
