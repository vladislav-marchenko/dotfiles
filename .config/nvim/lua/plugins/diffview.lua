-- Git diff в nvim: diffview.nvim
-- :DiffviewOpen [rev] [flags]  |  :DiffviewFileHistory [paths] [flags]

local function git(cmd)
  local out = vim.fn.systemlist("git " .. cmd)
  if vim.v.shell_error ~= 0 or not out[1] then
    return nil
  end
  return vim.trim(out[1])
end

--- Определяет базовую ветку репозитория: origin/HEAD -> main -> master -> develop
local function base_branch()
  local head = git("symbolic-ref --quiet --short refs/remotes/origin/HEAD")
  if head then
    return head -- например "origin/main"
  end
  for _, name in ipairs({ "main", "master", "develop", "dev" }) do
    if git("rev-parse --verify --quiet " .. name) then
      return name
    end
  end
  return "HEAD"
end

--- Открыть/закрыть diffview (toggle), чтобы не плодить вкладки
local function diffview(args)
  local ok, lib = pcall(require, "diffview.lib")
  if ok and lib.get_current_view() then
    vim.cmd("DiffviewClose")
  end
  vim.cmd("DiffviewOpen " .. (args or ""))
end

return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewFileHistory",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewRefresh",
  },
  keys = {
    -- === Diff ===
    {
      "<leader>gd",
      function()
        diffview()
      end,
      desc = "Diff: рабочая копия vs HEAD",
    },
    {
      "<leader>gs",
      function()
        diffview("--cached")
      end,
      desc = "Diff: staged (index vs HEAD)",
    },
    {
      "<leader>gm",
      function()
        local base = base_branch()
        diffview(base .. "...HEAD --imply-local")
      end,
      desc = "Diff: вся ветка vs base",
    },
    {
      "<leader>gM",
      function()
        vim.ui.input({ prompt = "Diff vs rev: ", default = base_branch() }, function(rev)
          if rev and rev ~= "" then
            diffview(rev .. "...HEAD --imply-local")
          end
        end)
      end,
      desc = "Diff: вся ветка vs произвольный rev",
    },
    {
      "<leader>gl",
      function()
        diffview("HEAD~1")
      end,
      desc = "Diff: последний коммит",
    },

    -- === История ===
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "История текущего файла" },
    {
      "<leader>gh",
      "<esc><cmd>'<,'>DiffviewFileHistory<cr>",
      mode = "v",
      desc = "История выделенных строк",
    },
    { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "История ветки (все коммиты)" },
    {
      "<leader>gL",
      function()
        local base = base_branch()
        vim.cmd("DiffviewFileHistory --range=" .. base .. "..HEAD")
      end,
      desc = "История: коммиты только этой ветки",
    },

    -- === Управление ===
    { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Закрыть diffview" },
    { "<leader>ge", "<cmd>DiffviewToggleFiles<cr>", desc = "Тогл панели файлов" },
    { "<leader>gf", "<cmd>DiffviewFocusFiles<cr>", desc = "Фокус на панель файлов" },
  },
  opts = function()
    local actions = require("diffview.actions")

    return {
      enhanced_diff_hl = true, -- более читаемая подсветка diff
      view = {
        default = { layout = "diff2_horizontal", winbar_info = true },
        merge_tool = {
          layout = "diff3_mixed",
          disable_diagnostics = true,
          winbar_info = true,
        },
        file_history = { layout = "diff2_horizontal", winbar_info = true },
      },
      file_panel = {
        listing_style = "tree",
        tree_options = { flatten_dirs = true, folder_statuses = "only_folded" },
        win_config = { position = "left", width = 32 },
      },
      file_history_panel = {
        win_config = { position = "bottom", height = 14 },
      },
      keymaps = {
        view = {
          { "n", "<leader>gc", actions.close, { desc = "Закрыть diffview" } },
          { "n", "<tab>", actions.select_next_entry, { desc = "Следующий файл" } },
          { "n", "<s-tab>", actions.select_prev_entry, { desc = "Предыдущий файл" } },
          { "n", "gf", actions.goto_file_edit, { desc = "Открыть файл в рабочей копии" } },
          { "n", "<leader>ge", actions.toggle_files, { desc = "Тогл панели файлов" } },
          { "n", "<leader>gf", actions.focus_files, { desc = "Фокус на панель файлов" } },
        },
        file_panel = {
          { "n", "<leader>gc", actions.close, { desc = "Закрыть diffview" } },
          { "n", "<cr>", actions.focus_entry, { desc = "Открыть файл и перейти в него" } },
          { "n", "s", actions.toggle_stage_entry, { desc = "Stage / unstage файл" } },
          { "n", "S", actions.stage_all, { desc = "Stage всё" } },
          { "n", "U", actions.unstage_all, { desc = "Unstage всё" } },
          { "n", "X", actions.restore_entry, { desc = "Откатить файл" } },
          { "n", "R", actions.refresh_files, { desc = "Обновить" } },
          { "n", "i", actions.listing_style, { desc = "Список / дерево" } },
        },
        file_history_panel = {
          { "n", "<leader>gc", actions.close, { desc = "Закрыть diffview" } },
          { "n", "<cr>", actions.focus_entry, { desc = "Открыть коммит" } },
          { "n", "y", actions.copy_hash, { desc = "Скопировать hash коммита" } },
          { "n", "g!", actions.options, { desc = "Опции лога" } },
        },
      },
    }
  end,
}
