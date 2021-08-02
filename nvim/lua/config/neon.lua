local c = require('neon.colors')
c.black = "#000000"
local highlight = require('neon.utils').highlight

vim.o.termguicolors = true
vim.g.neon_bold = true
vim.g.neon_transparent = true
vim.g.neon_style = "default"

vim.cmd[[colorscheme neon]]

local search = { bg = c.diff_yellow, fg = c.black }
local groups = {
-- Color Tweaks
  IncSearch = search,
  Visual = search,
  CursorLineNr = { fg = c.orange, bg = c.none },
  LineNr = { fg = c.gray, bg = none },
  NvimTreeRootFolder = { fg = c.gray_alt },
  NvimTreeGitDirty = { fg = c.red },
  CocHighlightText = { style = 'reverse' },
-- Compe
  CompeDocumentation = { fg = c.fg, bg = c.bg0 } 
}

for group, parameters in pairs(groups) do
  highlight(group, parameters)
end

