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
		"vhyrro/luarocks.nvim",
		priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
		config = true,
	},
	{
		"rest-nvim/rest.nvim",
		ft = "http",
		dependencies = { "luarocks.nvim" },
		config = function()
			require("rest-nvim").setup({
				result = {
					split = {
						horizontal = true,
						in_place = true,
					},
				},
			})
		end,
	},
}
