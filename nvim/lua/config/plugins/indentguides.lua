local M = {}

M.setup = function()
  vim.opt.list = true

  require("indent_blankline").setup {
    show_end_of_line = true,
    buftype_exclude = { "terminal", "Telescope", "TelescopeResult" },
    filetype_exclude = { "terminal", "Telescope", "TelescopeResult" },
    show_current_context = true,
  }
end
return M
