return {
	"tpope/vim-fugitive",
	{ "lewis6991/gitsigns.nvim", config = true },
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = true,
		opts = { default_mappings = false },
	},
	{
		"rest-nvim/rest.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("rest-nvim").setup({
				--- Get the same options from Packer setup
				result_split_in_place = true,
				result = { show_curl_command = true },
			})
		end,
	},
}
