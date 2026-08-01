return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = false,
      delay = 200,
      ignore_whitespace = false,
    },
    current_line_blame_formatter = "<author>, <author_time:%R> · <summary>",
    on_attach = function(buffer)
      local gitsigns = require("gitsigns")

      vim.keymap.set("n", "<leader>gb", function()
        gitsigns.blame_line({ full = true })
      end, { buffer = buffer, desc = "Git blame line" })

      vim.keymap.set("n", "<leader>tb", gitsigns.toggle_current_line_blame, {
        buffer = buffer,
        desc = "Toggle Git blame",
      })
    end,
  },
}
