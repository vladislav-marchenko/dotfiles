vim.opt.mouse = "a"
vim.opt.encoding = "utf-8"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false
vim.opt.autoindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 3
vim.opt.laststatus = 3

function _G.git_blame_statusline()
  local blame = vim.b.gitsigns_blame_line or ""
  local branch = vim.b.gitsigns_head or ""
  local available_width = vim.o.columns - vim.fn.strdisplaywidth(branch) - 10

  if available_width <= 1 then
    return ""
  end

  if vim.fn.strdisplaywidth(blame) > available_width then
    return vim.fn.strcharpart(blame, 0, available_width - 1) .. "…"
  end

  return blame
end

vim.opt.statusline = "  %{get(b:, 'gitsigns_head', '') ==# '' ? '' : ' ' . get(b:, 'gitsigns_head', '')} %= %{v:lua.git_blame_statusline()}  "
vim.cmd.colorscheme("github_dark_dimmed")
vim.opt.termguicolors = true
vim.opt.spelllang = "en_us,ru_ru"
vim.opt.spell = true
