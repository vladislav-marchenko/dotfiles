local function close_buffer()
  local buffer = vim.api.nvim_get_current_buf()

  if not vim.bo[buffer].modified then
    vim.cmd.bdelete({ args = { tostring(buffer) } })
    return
  end

  local choice = vim.fn.confirm(
    "This buffer has unsaved changes",
    "&1 Save and close\n&2 Discard changes\n&3 Cancel",
    3,
    "Warning"
  )

  if choice == 1 then
    local saved, error_message = pcall(vim.api.nvim_buf_call, buffer, function()
      vim.cmd.write()
    end)

    if not saved then
      vim.notify(error_message, vim.log.levels.ERROR)
      return
    end

    vim.cmd.bdelete({ args = { tostring(buffer) } })
  elseif choice == 2 then
    vim.cmd.bdelete({ bang = true, args = { tostring(buffer) } })
  end
end

return {
  "akinsho/bufferline.nvim",
  version = "*",
  lazy = false,
  dependencies = "nvim-tree/nvim-web-devicons",
  opts = {
    options = {
      diagnostics = "nvim_lsp",
    },
  },
  keys = {
    { "H", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
    { "L", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    { "<leader>bd", close_buffer, desc = "Close buffer" },
  },
}
