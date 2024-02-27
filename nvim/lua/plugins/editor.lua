return {
	"JoosepAlviste/nvim-ts-context-commentstring",
	{
		"gbprod/yanky.nvim",
		config = true,
		init = function()
			vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
			vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
			vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
			vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
			vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

			vim.keymap.set("n", "[[", "<Plug>(YankyPreviousEntry)")
			vim.keymap.set("n", "]]", "<Plug>(YankyNextEntry)")
		end,
		opts = {
			system_clipboard = {
				sync_with_ring = true,
			},
			highlight = {
				on_yank = false,
				on_paste = false,
				timer = 0,
			},
		},
	},
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
	"machakann/vim-sandwich",
	{ "NvChad/nvim-colorizer.lua", config = true },
	{ "max397574/better-escape.nvim", opts = { mapping = { "nn" }, timeout = 200 } },
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
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
}
