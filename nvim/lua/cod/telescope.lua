-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require("telescope").setup({
	-- defaults = { mappings = { i = { ["<C-u>"] = false, ["<C-d>"] = false } } },
	extensions = {
		whaler = {
			-- Whaler configuration
			-- file_explorer = "oil",
			auto_file_explorer = false,
			directories = {
				{ alias = "work", path = "~/code/work/" },
				{ alias = "pers", path = "~/code/personal/" },
				{ alias = "ntn", path = "~/code/ntn/" },
				{ alias = "dotf", path = "~/.config/" },
				{ alias = "nex-mono", path = "~/code/work/nexconnect-credit/frontend" },
				{ alias = "liftup-mono", path = "~/code/work/liftup-monorepo/frontend" },
				{ alias = "liftup-mono", path = "~/code/work/liftup-monorepo/backend" },
				{ alias = "liftup-mono", path = "~/code/work/liftup-monorepo/packages" },
			},
			-- You may also add directories that will not be searched for subdirectories
			oneoff_directories = {
				--{ path = "path/to/another/project", alias = "Project Z" },
			},
		},
	},
})
-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")
require("telescope").load_extension("whaler")
-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>o", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set(
	"n",
	"<leader>/",
	require("telescope.builtin").current_buffer_fuzzy_find,
	{ desc = "[/] Fuzzily search in current buffer" }
)
vim.keymap.set("n", "<leader>pp", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
vim.keymap.set("n", "<leader>py", "<cmd>Telescope yank_history<cr>", { desc = "Search [P]aste [Y]anks" })
vim.keymap.set("n", "<leader>pa", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>pj", "<cmd>Telescope whaler<cr>", { desc = "[S]earch [P]rojects" })
vim.keymap.set("n", "<leader>ph", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>pw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>pf", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>pd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>pc", require("telescope.builtin").colorscheme)
vim.keymap.set("n", "<leader>pk", require("telescope.builtin").keymaps)
vim.keymap.set("n", "<leader>gb", require("telescope.builtin").git_branches)
vim.keymap.set("n", "<leader>pi", "<cmd>DevdocsOpen<cr>")

require("telescope").load_extension("ui-select")
require("telescope").load_extension("yank_history")
