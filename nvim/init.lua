require('base')
require('plugins')
require('remap')

require'lspconfig'.tsserver.setup ({
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end,
  commands = {
    OrganizeImports = {
      function()
        vim.lsp.buf.execute_command({ command = "_typescript.organizeImports", arguments = { vim.api.nvim_buf_get_name(0) } })
      end
    }
  }
})

require'bufferline'.setup{
  options = {
    numbers = 'buffer_id'
  }
}

require'colorizer'.setup()

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "javascript", "typescript", "css", "yaml", "html" },
  highlight = {
    enable = true 
  }
}

require'gitsigns'.setup {
  current_line_blame = true,
}

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.code_actions.gitsigns
  },
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.cmd("nnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.formatting()<CR>")

      -- format on save
      vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()")
    end

    if client.server_capabilities.documentRangeFormattingProvider then
      vim.cmd("xnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.range_formatting({})<CR>")
    end  end,
})


local prettier = require('prettier')

prettier.setup({
  bin = 'prettier',
  filetypes = {
      "css",
      "graphql",
      "html",
      "javascript",
      "javascriptreact",
      "json",
      "less",
      "markdown",
      "scss",
      "typescript",
      "typescriptreact",
      "yaml",
    }})

vim.cmd('let NERDTreeWinSize = 64')
