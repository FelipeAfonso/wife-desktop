return {
    {'windwp/nvim-ts-autotag', opts = {enable_close_on_slash = false}}, {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {'nvim-treesitter/nvim-treesitter-textobjects'},
        build = ':TSUpdate'
    }, {
        'ggandor/leap.nvim',
        init = function() require('leap').add_default_mappings() end
    }, 'ggandor/leap-ast.nvim'
}
