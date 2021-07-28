local c = require('neon.colors')
c.black = "#000000"
local highlight = require('neon.utils').highlight

vim.g.neon_bold = true
vim.g.neon_transparent = true
vim.g.neon_style = "default"

vim.cmd[[colorscheme neon]]

local groups = {
-- Color Tweaks
  IncSearch = { bg = c.diff_yellow, fg = c.black },
  Visual = { bg = c.diff_yellow, fg = c.black },
  CursorLineNr = { fg = c.orange, bg = c.none },
  LineNr = { fg = c.gray, bg = none },
  NvimTreeRootFolder = { fg = c.gray_alt },
  NvimTreeGitDirty = { fg = c.red },
  CocHighlightText = { style = 'reverse' },
-- Transparency
  NvimTreeNormal = { bg = c.none },
}

for group, parameters in pairs(groups) do
  highlight(group, parameters)
end

