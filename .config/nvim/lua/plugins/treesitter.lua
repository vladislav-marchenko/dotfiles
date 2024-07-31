return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = { "windwp/nvim-ts-autotag", "windwp/nvim-autopairs" },
	opts = {
		ensure_installed = {
			"json",
			"javascript",
			"typescript",
			"tsx",
			"yaml",
			"html",
			"css",
			"prisma",
			"markdown",
			"markdown_inline",
			"svelte",
			"graphql",
			"bash",
			"lua",
			"vim",
			"dockerfile",
			"gitignore",
			"query",
			"vimdoc",
			"c",
			"python",
		},
		hightlight = { enable = true },
		indent = { enable = true },
		autotag = { enable = true },
	},
	config = function()
		require("nvim-ts-autotag").setup({
			opts = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = false,
			},
		})

		require("nvim-autopairs").setup({
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = true,
		})
	end,
}
