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
        display = {
          diff = {
            enabled = true,
            close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
            layout = 'vertical', -- vertical|horizontal split for default provider
            opts = { 'closeoff' },
            provider = 'default', -- default|mini_diff
          },
        },
        strategies = {
          chat = {
            adapter = 'anthropic',
          },
          inline = {
            adapter = 'anthropic',
          },
          agent = {
            adapter = 'anthropic',
          },
        },
        adapters = {
          anthropic = function()
            return require('codecompanion.adapters').extend('anthropic', {
              schema = {
                model = {
                  default = 'claude-3-5-sonnet-latest',
                },
              },
            })
          end,
          --   codellama = function()
          --     return require('codecompanion.adapters').extend('ollama', {
          --       name = 'codellama', -- Ensure the model is differentiated from Ollama
          --       schema = {
          --         model = {
          --           default = 'codellama:70b',
          --         },
          --       },
          --     })
          --   end,
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
