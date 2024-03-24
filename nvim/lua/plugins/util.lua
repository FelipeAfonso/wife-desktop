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
      config = function()
        require("luarocks").setup({})
      end,
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
}
}
        })
      end,
    }
}
