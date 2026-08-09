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

      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = desc })
      end

      -- gitsigns >= 1.0 использует nav_hunk, более старые — next_hunk/prev_hunk
      local function nav(direction)
        return function()
          if vim.wo.diff then
            vim.cmd.normal({ direction == "next" and "]c" or "[c", bang = true })
          elseif gitsigns.nav_hunk then
            gitsigns.nav_hunk(direction)
          else
            local fn = direction == "next" and gitsigns.next_hunk or gitsigns.prev_hunk
            fn()
          end
        end
      end

      -- === Навигация по хункам ===
      map("n", "]h", nav("next"), "Следующий хунк")
      map("n", "[h", nav("prev"), "Предыдущий хунк")

      -- === Просмотр ===
      map("n", "<leader>gp", gitsigns.preview_hunk, "Показать хунк (popup)")
      map("n", "<leader>gP", gitsigns.preview_hunk_inline, "Показать хунк (inline)")
      map("n", "<leader>gv", gitsigns.diffthis, "Diff файла vs index (split)")
      map("n", "<leader>gV", function()
        gitsigns.diffthis("~")
      end, "Diff файла vs HEAD (split)")

      -- === Staging по хункам ===
      map("n", "<leader>ga", gitsigns.stage_hunk, "Stage хунк")
      map("v", "<leader>ga", function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Stage выделенные строки")
      map("n", "<leader>gA", gitsigns.stage_buffer, "Stage весь файл")
      map("n", "<leader>gu", gitsigns.undo_stage_hunk or gitsigns.stage_hunk, "Отменить stage хунка")

      -- === Откат изменений ===
      map("n", "<leader>gr", gitsigns.reset_hunk, "Откатить хунк")
      map("v", "<leader>gr", function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Откатить выделенные строки")
      map("n", "<leader>gR", gitsigns.reset_buffer, "Откатить весь файл")

      -- === Список изменений ===
      map("n", "<leader>gq", function()
        gitsigns.setqflist("all")
      end, "Все изменения репо в quickfix")

      -- === Blame ===
      map("n", "<leader>gb", function()
        gitsigns.blame_line({ full = true })
      end, "Git blame line")
      map("n", "<leader>tb", gitsigns.toggle_current_line_blame, "Toggle Git blame")

      -- === Text object: ih — «внутри хунка» ===
      map({ "o", "x" }, "ih", gitsigns.select_hunk, "Хунк (text object)")
    end,
  },
}
