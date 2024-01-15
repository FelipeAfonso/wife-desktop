return {
    {
        'kylechui/nvim-surround',
        version = '*', -- Use for stability; omit to use `main` branch for the latest features
        event = 'VeryLazy',
        config = function()
            require('nvim-surround').setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {'max397574/better-escape.nvim', opts = {mapping = {'nn'}, timeout = 200}},
    {'NvChad/nvim-colorizer.lua', config = true}
}
