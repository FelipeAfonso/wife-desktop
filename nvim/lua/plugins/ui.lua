return {
	{
		"stevearc/dressing.nvim",
		opts = {},
		config = true,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = true,
		opts = {
			indent = {
				char = "┊",
				tab_char = "┊",
			},
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
			},
		},
	},
	{
		-- Set lualine as statusline
		"nvim-lualine/lualine.nvim",
		-- See `:help lualine.txt`
		opts = {
			options = {
				icons = false,
				component_separators = "|",
				theme = "tokyonight",
				section_separators = "",
			},
			sections = {
				lualine_c = { { "filename", path = 4 } },
				lualine_y = {},
				lualine_x = { "filetype" },
			},
		},
	},
	{
		"aserowy/tmux.nvim",
		config = function(_, opts)
			require("tmux").setup(opts)
			vim.keymap.set("n", "<C-n>", '<cmd>lua require("tmux").move_bottom()<cr>')
			vim.keymap.set("n", "<C-e>", '<cmd>lua require("tmux").move_top()<cr>')
			vim.keymap.set("n", "<C-l>", '<cmd>lua require("tmux").move_left()<cr>')
			vim.keymap.set("n", "<C-i>", '<cmd>lua require("tmux").move_right()<cr>')
			vim.keymap.set("n", "<M-n>", '<cmd>lua require("tmux").resize_bottom()<cr>')
			vim.keymap.set("n", "<M-e>", '<cmd>lua require("tmux").resize_top()<cr>')
			vim.keymap.set("n", "<M-l>", '<cmd>lua require("tmux").resize_left()<cr>')
			vim.keymap.set("n", "<M-i>", '<cmd>lua require("tmux").resize_right()<cr>')
		end,
		opts = {
			navigation = { enable_default_keybindings = false },
			copy_sync = { enable = false },
			resize = { enable_default_keybindings = false },
		},
	},
}
