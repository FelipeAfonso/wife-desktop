return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        '<leader>f',
        function()
          require('conform').format { async = true }
        end,
        mode = '',
        desc = 'Format buffer',
      },
    },
    -- This will provide type hinting with LuaLS
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      -- Define your formatters
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettierd', 'eslint_d', lsp_format = 'never' },
        typescript = { 'prettierd', 'eslint_d', lsp_format = 'never' },
        javascriptreact = { 'prettierd', 'eslint_d', lsp_format = 'never' },
        typescriptreact = { 'prettierd', 'eslint_d', lsp_format = 'never' },
        svelte = { 'prettierd', 'prettier', stop_after_first = true, lsp_format = 'never' },
        templ = { 'templ', 'prettier' },
        json = { 'prettier', 'jq', stop_after_first = true },
        jsonc = { 'prettier', stop_after_first = true },
        md = { 'markdownlint' },
      },
      -- Set default options
      default_format_opts = {
        lsp_format = 'fallback',
      },
      -- Set up format-on-save
      format_on_save = { timeout_ms = 500 },
      log_level = vim.log.levels.DEBUG,
    },
  },
}
