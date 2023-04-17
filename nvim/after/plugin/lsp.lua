-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
  -- Replace these with whatever servers you want to install
  'rust_analyzer',
  'tailwindcss',
  'tsserver',
  'eslint',
})

local cmp = require('cmp')

lsp.configure('tsserver', {
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.document_range_formatting = false
  end,
  commands = {
    OrganizeImports = {
      function()
        vim.lsp.buf.execute_command({
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(0) }
        })
      end
    }
  }
})

lsp.nvim_workspace()

local null_ls = require('null-ls')
local null_opts = lsp.build_options('null-ls', {
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        desc = "Auto format before save",
        pattern = "<buffer>",
        callback = function()
          vim.lsp.buf.format({
            bufnr = bufnr,
            filter = function(c) return c.name == "null-ls" end
          })
        end,
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

lsp.setup_nvim_cmp({
  mapping = lsp.defaults.cmp_mappings({
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
  })
})

lsp.setup()
