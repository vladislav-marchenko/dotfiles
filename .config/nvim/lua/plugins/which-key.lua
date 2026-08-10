-- Подсказка по кеймапам: нажми <leader> (пробел) и подожди — всплывёт меню.
-- <F1>       — все кеймапы с корня, включая не-leader (]h, gd, zz, <c-w>...)
-- <leader>?  — кеймапы текущего буфера (в панели diffview покажет i, s, S, X...)
-- <leader>fk — полный поиск по всем кеймапам через telescope
-- :WhichKey [keys] — то же самое командой, без биндинга

--- langmapper с hack_keymap = true дублирует все биндинги в русской раскладке.
--- В which-key они не нужны — отфильтровываем всё, где в lhs есть кириллица.
--- (0xD0/0xD1 — ведущие байты кириллицы в UTF-8, в ASCII-кеймапах их не бывает)
local function is_cyrillic(lhs)
  return lhs ~= nil and lhs:find("[\208\209]") ~= nil
end

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<F1>",
      function()
        -- без аргументов — корень: показывает ВСЕ кеймапы, не только <leader>.
        -- loop = true — попап не закрывается после выбора, можно ходить по веткам
        require("which-key").show({ loop = true })
      end,
      mode = { "n", "v" },
      desc = "Все кеймапы (which-key)",
    },
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Кеймапы текущего буфера",
    },
    {
      "<leader>fk",
      "<cmd>Telescope keymaps<cr>",
      desc = "Поиск по всем кеймапам",
    },
  },
  opts = {
    preset = "modern",
    -- Задержка перед всплытием попапа, мс.
    -- ctx.plugin — встроенные пресеты (marks, registers, spelling): им задержка не нужна.
    -- Крути 700 под себя: меньше — назойливее, больше — реже мешает.
    delay = function(ctx)
      return ctx.plugin and 0 or 700
    end,
    filter = function(mapping)
      return not is_cyrillic(mapping.lhs)
    end,
    icons = {
      mappings = false, -- без иконок перед каждым пунктом
    },
    spec = {
      { "<leader>g", group = "git / lsp" },
      { "<leader>gw", desc = "Diff: рабочая копия vs HEAD" },
      { "<leader>gd", desc = "LSP: go to definition" },
      { "<leader>gr", desc = "LSP: references" },
      { "<leader>f", group = "find / telescope" },
      { "<leader>e", group = "explorer (nvim-tree)" },
      { "<leader>b", group = "buffer" },
      { "<leader>bu", desc = "Открыть последний закрытый буфер" },
      { "<leader>t", group = "toggle" },
      { "]", group = "next" },
      { "[", group = "prev" },
      { "]h", desc = "Следующий хунк" },
      { "[h", desc = "Предыдущий хунк" },
    },
  },
}
