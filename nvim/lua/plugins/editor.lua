return {
	"JoosepAlviste/nvim-ts-context-commentstring",
	"mg979/vim-visual-multi",
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
	-- { "echasnovski/mini.pairs", version = "*", config = true },
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
	{
		"ggandor/leap.nvim",
		config = function()
			vim.keymap.set({ "n", "x", "o" }, "ss", "<Plug>(leap-forward)")
			vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
			vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)")
			vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
		end,
		dependencies = {
			"tpope/vim-repeat",
		},
	},
	{ "NvChad/nvim-colorizer.lua", config = true },
	{ "max397574/better-escape.nvim", opts = { mapping = { "nn" }, timeout = 200 } },
	{
		"zbirenbaum/copilot.lua",
		config = true,
		opts = {
			suggestion = {
				enabled = true,
				auto_trigger = false,
				debounce = 50,
				keymap = {
					accept = "<C-f>",
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
			},
			filetypes = {
				yaml = true,
				["."] = false,
			},
		},
	},
}
