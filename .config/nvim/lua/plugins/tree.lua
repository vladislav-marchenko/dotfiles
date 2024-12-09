return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = "nvim-web-devicons",
    opts = {
      view = {
        side = 'right'
      },
      filters = {
        dotfiles = false,
        git_ignored = false,
      }
    },
    keys = {
      { "<leader>ee", ":NvimTreeToggle<cr>",   silent = true, desc = "Toggle nvim tree" },
      --[[ {
        "<leader>ef",
        ":NvimTreeFindFileToggle<cr>",
        silent = true,
        desc = "Toggle nvim tree on the current file",
      }, --]]
      { "<leader>ec", ":NvimTreeCollapse<cr>", silent = true, desc = "Collapse nvim tree" },
      { "<leader>ef", ":NvimTreeFocus<cr>",    silent = true, desc = "Focus nvim tree" },
    },
  },
  {
    "nvim-tree/nvim-web-devicons",
    opts = {
      override = {
        zsh = {
          icon = "",
          color = "#428850",
          cterm_color = "65",
          name = "Zsh",
        },
      },
      color_icons = true,
      default = true,
    },
  },
}
