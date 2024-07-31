return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = "nvim-lua/plenary.nvim",
	config = function()
		local builtin = require("telescope.builtin")
		local actions = require("telescope.actions")

		vim.keymap.set("n", "<leader>ff", builtin.find_files)
		vim.keymap.set("n", "<leader>fg", builtin.live_grep)

		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						-- j, k for normal mode and C-j, C-k for other modes
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
					},
				},
			},
		})
	end,
}
