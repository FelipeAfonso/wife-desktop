return {
	"RRethy/vim-illuminate",
	"JoosepAlviste/nvim-ts-context-commentstring",
	{ "echasnovski/mini.pairs", version = "*", config = true },
	{
		"echasnovski/mini.comment",
		version = "*",
		opts = {
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring()
						or vim.bo.commentstring
				end,
			},
		},
	},
	{
		"echasnovski/mini.surround",
		version = "*",
		opts = {
			mappings = {
				add = "ys", -- Add surrounding in Normal and Visual modes
				delete = "ysd", -- Delete surrounding
				replace = "ysr", -- Replace surrounding
			},
		},
	},
	{ "NvChad/nvim-colorizer.lua", config = true },
	{ "max397574/better-escape.nvim", opts = { mapping = { "nn" }, timeout = 200 } },
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
		keys = {
			{ "<leader>xx", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
			{ "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
}
