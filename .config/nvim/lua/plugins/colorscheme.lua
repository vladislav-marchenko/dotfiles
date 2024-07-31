return {
	{
		"tiagovla/tokyodark.nvim",
		opts = {
			-- custom options here
		},
		config = function(_, opts)
			require("tokyodark").setup(opts) -- calling setup is optional
			vim.cmd([[colorscheme tokyodark]])
		end,
	},
	{
		"navarasu/onedark.nvim",
		opts = {
			style = "dark", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
			transparent = false, -- Show/hide background
			term_colors = true, -- Change terminal color as per the selected theme style
			ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
			cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

			-- toggle theme style ---
			toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
			toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between

			-- Change code style ---
			-- Options are italic, bold, underline, none
			-- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
			code_style = {
				comments = "italic",
				keywords = "none",
				functions = "none",
				strings = "none",
				variables = "none",
			},

			-- Lualine options --
			lualine = {
				transparent = false, -- lualine center bar transparency
			},

			-- Custom Highlights --
			colors = {}, -- Override default colors
			highlights = {}, -- Override highlight groups

			-- Plugins Config --
			diagnostics = {
				darker = true, -- darker colors for diagnostic
				undercurl = true, -- use undercurl instead of underline for diagnostics
				background = true, -- use background color for virtual text
			},
		},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		opts = {
			-- transparent_background = true,
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
			-- For transparent background
			--[[ custom_highlights = {
				Visual = { bg = "#747474" },
				LineNr = { fg = "#aeb0b7" },
				EndOfBuffer = { fg = "#aeb0b7" },
				Comment = { fg = "#aeb0b7" },
				Search = { bg = "#865e91" },
			}, --]]
			integrations = {
				treesitter = true,
			},
		},
	},
}
