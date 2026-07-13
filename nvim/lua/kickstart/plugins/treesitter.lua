return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'main', -- master is frozen and incompatible with nvim 0.12
    build = ':TSUpdate',
    lazy = false,
    config = function()
      local ensure_installed = {
        'c',
        'cpp',
        'css',
        'go',
        'html',
        'http',
        'javascript',
        'json',
        'lua',
        'markdown',
        'markdown_inline',
        'odin',
        'python',
        'rust',
        'svelte',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
      }
      require('nvim-treesitter').install(ensure_installed)

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('treesitter-start', { clear = true }),
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if lang and vim.treesitter.language.add(lang) then
            vim.treesitter.start(args.buf, lang)
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
