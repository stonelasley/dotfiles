local c = {
  black = "#000000",
  diff_yellow = "#fabd2f",
  gray = "#7e8294",
  gray_alt = "#4C566A",
  orange = "#da8548",
  none = "NONE",
}

local search = { bg = c.diff_yellow, fg = c.black }

return {
  IncSearch = search,
  Visual = search,
  LineNr = { fg = c.gray, bg = c.none },
  NvimTreeRootFolder = { fg = c.gray_alt },
  NvimTreeGitDirty = { fg = c.red },
  NvimTreeNormal = { bg = c.none },
  Normal = { bg = c.none },
  CursorLine = { bg = c.none },
}
