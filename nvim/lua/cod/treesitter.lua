-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require("nvim-treesitter.configs").setup({
	-- Add languages to be installed here that you want installed for treesitter
	ensure_installed = {
		"c",
		"cpp",
		"css",
		"go",
		"lua",
		"python",
		"rust",
		"svelte",
		"tsx",
		"typescript",
		"vimdoc",
		"vim",
	},

	-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
	auto_install = true,

	highlight = { enable = true },
	indent = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>",
			scope_incremental = "<CR>",
			node_incremental = "<TAB>",
			node_decremental = "<S-TAB>",
		},
	},
	textobjects = {
		select = {
			enable = true,
			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				-- You can also use captures from other query groups like `locals.scm`
				["as"] = {
					query = "@scope",
					query_group = "locals",
					desc = "Select language scope",
				},
			},
		},
		move = {
			enable = true,
		},
	},
})
