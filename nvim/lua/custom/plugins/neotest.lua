return {
  'nvim-neotest/neotest',
  lazy = true,
  ft = { 'typescript' },
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'thenbe/neotest-playwright',
    'marilari88/neotest-vitest',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-vitest',
        require('neotest-playwright').adapter {
          options = {
            -- preset = 'debug',
            persist_project_selection = true,
            enable_dynamic_test_discovery = true,
            get_playwright_binary = function()
              -- return vim.loop.cwd() .. '/node_modules/.bin/playwright'
              -- check if this exists, otherwise cd ../../ and check again
              local cwd_node = vim.loop.cwd() .. '/node_modules/.bin/playwright'
              if vim.fn.filereadable(cwd_node) == 1 then
                return cwd_node
              end
              return vim.loop.cwd() .. '/../../node_modules/.bin/playwright'
            end,
            is_test_file = function(file_path)
              local result = file_path:find '%.test%.[tj]sx?$' ~= nil or file_path:find '%.spec%.[tj]sx?$' ~= nil or file_path:find '%.setup%.[tj]sx?$' ~= nil
              return result
            end,
          },
        },
      },
    }
    -- keybinds
    vim.keymap.set('n', '<C-t>', function()
      require('neotest').run.run()
    end)
    vim.keymap.set('n', '<C-t>s', function()
      require('neotest').run.stop()
    end)
    vim.keymap.set('n', '<C-t>p', function()
      require('neotest').summary.toggle()
    end)
  end,
}
