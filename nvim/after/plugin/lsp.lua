-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.setup_servers({ 'tsserver', 'eslint' })

lsp.ensure_installed({
  -- Replace these with whatever servers you want to install
  'tsserver',
  'eslint',
  'sumneko_lua',
})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

local null_ls = require('null-ls')
local null_opts = lsp.build_options('null-ls', {
  on_attach = function(client)
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        desc = "Auto format before save",
        pattern = "<buffer>",
        callback = vim.lsp.buf.formatting_sync,
      })
      vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
    end
  end
})

null_ls.setup({
  on_attach = null_opts.on_attach,
  sources = {
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.diagnostics.eslint,
  }
})

lsp.setup()
