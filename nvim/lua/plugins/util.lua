return {
    'tpope/vim-fugitive', {
        'akinsho/git-conflict.nvim',
        version = "*",
        config = true,
        opts = {default_mappings = false}
    }, {
        'rest-nvim/rest.nvim',
        config = true,
        dependencies = {'nvim-lua/plenary.nvim'},
        opts = {
            result_split_in_place = true,
            result = {show_curl_command = true}
        }
    }
}
