return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope.nvim', -- Optional
      {
        'stevearc/dressing.nvim', -- Optional: Improves the default Neovim UI
      },
    },
    config = function()
      require('codecompanion').setup {
        strategies = {
          chat = {
            adapter = 'codellama',
          },
          inline = {
            adapter = 'codellama',
          },
          agent = {
            adapter = 'codellama',
          },
        },
        adapters = {
          codellama = function()
            return require('codecompanion.adapters').use('ollama', {
              name = 'codellama', -- Ensure the model is differentiated from Ollama
              schema = {
                model = {
                  default = 'codellama:7b',
                },
              },
            })
          end,
        },
      }

      vim.api.nvim_set_keymap('n', '<C-f>', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('v', '<C-f>', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>a', '<cmd>CodeCompanionToggle<cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('v', '<leader>a', '<cmd>CodeCompanionToggle<cr>', { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap('v', 'ga', '<cmd>CodeCompanionAdd<cr>', { noremap = true, silent = true })

      -- Expand 'cc' into 'CodeCompanion' in the command line
      vim.cmd [[cab cc CodeCompanion]]
    end,
  },
}
