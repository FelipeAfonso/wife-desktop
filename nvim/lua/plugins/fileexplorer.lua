return {
	{
		"kelly-lin/ranger.nvim",
		config = function()
			require("ranger-nvim").setup({
				replace_netrw = true,
				ui = { height = 0.95 },
			})
			vim.api.nvim_set_keymap("n", "<leader>t", "", {
				noremap = true,
				callback = function()
					require("ranger-nvim").open(true)
				end,
			})
		end,
	},
	"nvim-telescope/telescope-ui-select.nvim",
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		-- NOTE: If you are having trouble with this installation,
		--       refer to the README for telescope-fzf-native for more instructions.
		build = "make",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
	},
	{ "ThePrimeagen/harpoon", lazy = false, config = true },
	{ "chrisgrieser/nvim-early-retirement", config = true, event = "VeryLazy" },
}
