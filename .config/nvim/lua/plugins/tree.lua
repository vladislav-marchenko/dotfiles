local tree_width = "25%"

local function remember_tree_width()
  for _, window in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_is_valid(window) then
      local buffer = vim.api.nvim_win_get_buf(window)
      if vim.api.nvim_get_option_value("filetype", { buf = buffer }) == "NvimTree" then
        local width = vim.api.nvim_win_get_width(window)
        if width > 0 then
          tree_width = width
        end
        return
      end
    end
  end
end

return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = "nvim-web-devicons",
    opts = {
      view = {
        side = "right",
        width = function()
          return tree_width
        end,
        preserve_window_proportions = true,
      },
      filters = {
        dotfiles = false,
        git_ignored = false,
      },
      update_focused_file = {
        enable = true,
        update_root = {
          enable = false,
        },
      },
    },
    config = function(_, opts)
      require("nvim-tree").setup(opts)

      local group = vim.api.nvim_create_augroup("NvimTreeRememberWidth", { clear = true })
      vim.api.nvim_create_autocmd("WinResized", {
        group = group,
        callback = remember_tree_width,
      })
    end,
    keys = {
      { "<leader>ee", ":NvimTreeToggle<cr>",   silent = true, desc = "Toggle nvim tree" },
      { "<leader>ec", ":NvimTreeCollapse<cr>", silent = true, desc = "Collapse nvim tree" },
      {
        "<leader>ef",
        ":NvimTreeFindFile<cr>",
        silent = true,
        desc = "Reveal current file in tree",
      },
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
