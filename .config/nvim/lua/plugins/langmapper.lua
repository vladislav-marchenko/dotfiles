local function escape_langmap(value)
  return vim.fn.escape(value, [[;,."|\]])
end

local english = [=[ABCDEFGHIJKLMNOPQRSTUVWXYZ<>:"{}~abcdefghijklmnopqrstuvwxyz,.;'[]`]=]
local russian = [=[ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯБЮЖЭХЪЁфисвуапршолдьтщзйкыегмцчнябюжэхъё]=]

return {
  "Wansmer/langmapper.nvim",
  lazy = false,
  priority = 2000,
  init = function()
    vim.opt.langmap = table.concat({
      escape_langmap(russian) .. ";" .. escape_langmap(english),
    }, ",")
  end,
  opts = {
    hack_keymap = true,
    disable_hack_modes = { "c", "t" },
  },
}
