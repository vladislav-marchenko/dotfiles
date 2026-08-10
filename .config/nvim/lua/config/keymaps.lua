-- <Cmd> вместо ":" — команда выполняется напрямую, не через командную строку.
-- Через ":" её перехватывал which-key, когда прогонял отложенные клавиши.
vim.keymap.set("n", "<leader>,", "<Cmd>nohlsearch<CR>", { desc = "Убрать подсветку поиска" })

-- === Открыть последний закрытый буфер ===
-- Копим стек закрытых файлов, <leader>bu достаёт последний.

local closed = {}

vim.api.nvim_create_autocmd("BufDelete", {
  group = vim.api.nvim_create_augroup("reopen_closed_buffer", { clear = true }),
  callback = function(args)
    local name = args.file

    -- пропускаем безымянные, спецбуферы (nvim-tree, help, terminal) и то, чего нет на диске
    if not name or name == "" or vim.fn.filereadable(name) == 0 then
      return
    end

    -- без дублей: если файл уже в стеке, поднимаем его наверх
    for i, v in ipairs(closed) do
      if v == name then
        table.remove(closed, i)
        break
      end
    end

    table.insert(closed, name)

    -- не растим стек бесконечно
    if #closed > 50 then
      table.remove(closed, 1)
    end
  end,
})

vim.keymap.set("n", "<leader>bu", function()
  local name = table.remove(closed)

  if not name then
    vim.notify("Нет закрытых буферов", vim.log.levels.INFO)
    return
  end

  vim.cmd.edit(vim.fn.fnameescape(name))
end, { desc = "Открыть последний закрытый буфер" })
