return {
  "nvim-telescope/telescope.nvim",
  branch = "master",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    local builtin = require("telescope.builtin")
    local actions = require("telescope.actions")
    local find_files_with_hidden = function() builtin.find_files({ hidden = true }) end
    local literal_grep = function()
      builtin.live_grep({
        additional_args = function()
          return { "--fixed-strings" }
        end,
      })
    end
    local regex_grep = function()
      builtin.live_grep()
    end

    vim.keymap.set("n", "<leader>ff", find_files_with_hidden)
    vim.keymap.set("n", "<leader>fg", literal_grep, { desc = "Literal grep" })
    vim.keymap.set("n", "<leader>fr", regex_grep, { desc = "Regex grep" })

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
