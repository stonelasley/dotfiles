--local c = require('neon.colors')
local c = {
    black = '#000000',
    diff_yellow = '#fabd2f',
    gray = '#7e8294',
    gray_alt = '#4C566A',
    orange = '#da8548',
    none = 'NONE',
}
local utils = require('utils')

vim.o.termguicolors = true
-- vim.g.neon_bold = true
-- vim.g.neon_transparent = true
-- vim.g.neon_style = "default"

vim.cmd([[colorscheme nord]])

local search = { bg = c.diff_yellow, fg = c.black }
local groups = {
    -- Color Tweaks
    IncSearch = search,
    Visual = search,
    CursorLineNr = { fg = c.orange, bg = c.none },
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