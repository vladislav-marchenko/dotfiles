return {
	"hong4rc/copy-path.nvim",
	cmd = { "CopyRelativePath", "CopyAbsolutePath" },
	opts = {
		-- Не занимаем существующие хоткеи: плагин используется только командами.
		picker_keymap = false,
		which_key_group = false,
		keymaps = {
			relative = false,
			full = false,
			filename = false,
			stem = false,
			extension = false,
			dir_full = false,
			dir_rel = false,
			line = false,
			line_full = false,
			github = false,
			github_line = false,
		},
	},
	config = function(_, opts)
		local copy_path = require("copy-path")
		copy_path.setup(opts)

		vim.api.nvim_create_user_command("CopyRelativePath", function()
			copy_path.copy("relative")
		end, { desc = "Скопировать относительный путь текущего файла" })

		vim.api.nvim_create_user_command("CopyAbsolutePath", function()
			copy_path.copy("full")
		end, { desc = "Скопировать абсолютный путь текущего файла" })
	end,
}
