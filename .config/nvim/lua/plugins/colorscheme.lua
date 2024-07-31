return {
	{
		"navarasu/onedark.nvim",
		opts = {
			-- transparent = true,
			lazy = false,
			priority = 1000,
		},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		opts = {
			transparent_background = true,
			lazy = false,
			priority = 1000,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
				comments = { "italic" },
				conditionals = { "italic" },
				loops = {},
				functions = { "italic" },
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
				operators = {},
			},
			color_overrides = {},
			-- For transparent
			--[[custom_highlights = {
				Visual = { bg = "#747474" },
				LineNr = { fg = "#aeb0b7" },
				EndOfBuffer = { fg = "#aeb0b7" },
				Comment = { fg = "#aeb0b7" },
				Search = { bg = "#865e91" },
			},--]]
			integrations = {
				treesitter = true,
			},
		},
	},
}
