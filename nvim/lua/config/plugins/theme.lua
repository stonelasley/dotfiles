local M = {}
local c = {
  black = "#000000",
  diff_yellow = "#fabd2f",
  gray = "#7e8294",
  gray_alt = "#4C566A",
  orange = "#da8548",
  none = "NONE",
}

M.setup = function()
  local utils = require "utils"
  vim.o.termguicolors = true

  vim.cmd [[colorscheme onenord]]

  local search = { bg = c.diff_yellow, fg = c.black }
  local groups = {
    -- Color Tweaks
    IncSearch = search,
    Visual = search,
    Beacon = search,
    IndentBlanklineContextChar = { fg = c.diff_yellow },
    CursorLineNr = { fg = c.orange, bg = c.none },
    --Underline = { fg = c.orange, underline = true },
    LineNr = { fg = c.gray, bg = c.none },
    NvimTreeRootFolder = { fg = c.gray_alt },
    NvimTreeGitDirty = { fg = c.red },
    NvimTreeNormal = { bg = c.none },
    Normal = { bg = c.none },
    CursorLine = { bg = c.none },
  }

  for group, parameters in pairs(groups) do
    utils.highlight(group, parameters)
  end
end

return M
