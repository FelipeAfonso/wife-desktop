return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"folke/neodev.nvim",
		},
	},
	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",

			-- Adds LSP completion capabilities
			"hrsh7th/cmp-nvim-lsp", -- Adds a number of user-friendly snippets
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"stevearc/conform.nvim",
		init = function()
			vim.keymap.set("n", "<leader>f", '<cmd>lua require("conform").format()<cr>')
			-- format on save
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function(args)
					require("conform").format({ bufnr = args.buf })
				end,
			})
		end,
		opts = {
			formatters_by_ft = {
				lua = { { "stylua" } },
				nix = { { "rnix", "nixpkgs-fmt" } },
				javascript = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				jsx = { { "prettierd", "prettier" } },
				svelte = { { "prettierd", "prettier" } },
				json = { { "fixjson", "jsonlint", "prettier", "jq" } },
				jsonc = { { "fixjson", "jsonlint", "prettier" } },
			},
		},
	},
}
