return {
	"nvim-telescope/telescope-ui-select.nvim",
	{
		"stevearc/oil.nvim",
		config = true,
		init = function()
			vim.keymap.set("n", "<leader>t", "<cmd>Oil<cr>")
			-- vim.keymap.set("n", "<leader>T", "<cmd>require('oil').discard_all_changes<cr>")
		end,
		opts = {
			keymap = {
				["<CR>"] = "actions.select",
				["<C-p>"] = "actions.preview",
				["<C-l>"] = "actions.refresh",
				["Q"] = "actions.close",
				["-"] = "actions.parent",
				["g."] = "actions.toggle_hidden",
			},
			view_options = {
				show_hidden = true,
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim", "SalOrak/whaler", "nvim-tree/nvim-web-devicons" },
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
	{
		"luckasRanarison/nvim-devdocs",
		opts = {
			ensure_installed = {
				"axios",
				"cpp",
				"css",
				"go",
				"html",
				"http",
				"javascript",
				"react",
				"react_native",
				"rust",
				"svelte",
				"tailwindcss",
				"typescript",
				"vite",
			},
		},
	},
	{ "ThePrimeagen/harpoon", lazy = false, config = true },
	{ "chrisgrieser/nvim-early-retirement", config = true, event = "VeryLazy" },
	{
		"jiaoshijie/undotree",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
		keys = { -- load the plugin only when using it's keybinding:
			{ "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
		},
	},
	{
		"kelly-lin/ranger.nvim",
		config = function()
			require("ranger-nvim").setup({
				replace_netrw = true,
				ui = { height = 0.95 },
			})
			vim.api.nvim_set_keymap("n", "<leader>T", "", {
				noremap = true,
				callback = function()
					require("ranger-nvim").open(true)
				end,
			})
		end,
	},
}
