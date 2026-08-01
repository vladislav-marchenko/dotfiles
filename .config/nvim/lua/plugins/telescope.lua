return {
  "nvim-telescope/telescope.nvim",
  branch = "master",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    local builtin = require("telescope.builtin")
    local actions = require("telescope.actions")
    local layout_actions = require("telescope.actions.layout")
    local make_entry = require("telescope.make_entry")
    local sorters = require("telescope.sorters")
    local fzy = require("telescope.algos.fzy")

    local score_offset = -fzy.get_score_floor()

    local function fuzzy_cost(prompt, text)
      if not fzy.has_match(prompt, text) then
        return nil
      end

      local score = fzy.score(prompt, text)
      if score == fzy.get_score_max() then
        return 0
      end
      if score == fzy.get_score_min() then
        return 1
      end

      return 1 / (score + score_offset)
    end

    local function filename_first_sorter()
      return sorters.Sorter:new({
        discard = true,
        scoring_function = function(_, prompt, ordinal)
          if prompt == "" then
            return 1
          end

          local separator = ordinal:find("\31", 1, true)
          local filename = separator and ordinal:sub(1, separator - 1) or ordinal
          local path = separator and ordinal:sub(separator + 1) or ordinal
          local filename_lower = filename:lower()
          local prompt_lower = prompt:lower()

          if filename_lower:find(prompt_lower, 1, true) then
            return fuzzy_cost(prompt, filename) or 0
          end

          local filename_score = fuzzy_cost(prompt, filename)
          if filename_score then
            return 1 + filename_score
          end

          local path_score = fuzzy_cost(prompt, path)
          if path_score then
            return 2 + path_score
          end

          return -1
        end,
        highlighter = function(_, prompt, display)
          return fzy.positions(prompt, display)
        end,
      })
    end

    local find_files_with_hidden = function()
      local opts = {
        hidden = true,
        preview = { hide_on_startup = true },
        layout_config = {
          width = 0.98,
          height = 0.95,
        },
        sorter = filename_first_sorter(),
      }
      local default_entry_maker = make_entry.gen_from_file(opts)

      opts.entry_maker = function(line)
        local entry = default_entry_maker(line)
        if entry then
          local filename = vim.fs.basename(entry.filename or line)
          entry.ordinal = filename .. "\31" .. line
        end
        return entry
      end

      builtin.find_files(opts)
    end
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
        layout_strategy = "flex",
        path_display = { "filename_first" },
        layout_config = {
          flip_columns = 120,
          horizontal = {
            preview_cutoff = 1,
          },
          vertical = {
            preview_cutoff = 1,
          },
        },
        mappings = {
          i = {
            -- j, k for normal mode and C-j, C-k for other modes
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-p>"] = layout_actions.toggle_preview,
          },
          n = {
            ["<C-p>"] = layout_actions.toggle_preview,
          },
        },
      },
    })
  end,
}
