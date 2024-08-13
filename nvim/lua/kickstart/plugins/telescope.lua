-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin

return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'SalOrak/whaler' },
      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font, opts = {
        color_icons = true,
      } },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        defaults = {
          color_devicons = true,
        },
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          whaler = {
            -- Whaler configuration
            auto_file_explorer = false,
            directories = {
              { alias = 'work', path = '~/code/work/' },
              { alias = 'pers', path = '~/code/personal/' },
              { alias = 'dotf', path = '~/.config/' },
              { alias = 'liftup-mono', path = '~/code/work/liftup-monorepo/frontend' },
              { alias = 'liftup-mono', path = '~/code/work/liftup-monorepo/backend' },
              { alias = 'liftup-mono', path = '~/code/work/liftup-monorepo/packages' },
            },
            -- You may also add directories that will not be searched for subdirectories
            oneoff_directories = {
              --{ path = "path/to/another/project", alias = "Project Z" },
            },
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension 'whaler')
      pcall(require('telescope').load_extension 'yank_history')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>o', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
      vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>/', require('telescope.builtin').current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer' })
      vim.keymap.set('n', '<leader>pp', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
      vim.keymap.set('n', '<leader>pr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>py', '<cmd>Telescope yank_history<cr>', { desc = 'Search [P]aste [Y]anks' })
      vim.keymap.set('n', '<leader>pa', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>pj', '<cmd>Telescope whaler<cr>', { desc = '[S]earch [P]rojects' })
      vim.keymap.set('n', '<leader>ph', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>pw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>pf', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>pd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>pc', require('telescope.builtin').colorscheme)
      vim.keymap.set('n', '<leader>pk', require('telescope.builtin').keymaps)
      vim.keymap.set('n', '<leader>gb', require('telescope.builtin').git_branches)
      vim.keymap.set('n', '<leader>pi', '<cmd>DevdocsOpen<cr>')

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>pn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
