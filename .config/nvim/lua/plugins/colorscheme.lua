return {
  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
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
