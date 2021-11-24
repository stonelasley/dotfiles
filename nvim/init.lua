pcall(require, 'impatient')

local cmd = vim.cmd
local utils = require('utils')

cmd [[let &packpath = &runtimepath]]
cmd [[set rtp+=~/.fzf]]

utils.opt({'o', 'b'}, 'expandtab', true)
utils.opt({'o', 'b'}, 'smartindent', true)
utils.opt({'o', 'b'}, 'textwidth', 100)
utils.opt({'o', 'w'}, 'number', true)
utils.opt({'o', 'w'}, 'relativenumber', true)
utils.opt('o', 'splitbelow', true)
utils.opt('o', 'splitright', true)
utils.opt('w', 'wrap', false)
utils.opt('o', 'formatoptions', 'cro')
utils.opt('o', 'termguicolors', true)
vim.opt.clipboard:append("unnamedplus")
vim.g.indentLine_fileTypeExclude = {'json'}
vim.g.wrap = false
vim.g.ttimeoutlen=100
vim.g.guicursor='blinkon100'
vim.o.completeopt="menuone,preview,noinsert"

-- Highlight text on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
  ]],
  false
)
-- Temp Macros
vim.api.nvim_exec(
  [[

      let @l = '0wi{{ $t(''A'') }}j'
      let @b = '0f>a{{ $t(''f<i'') }}j'
      let @i = 'F>a{{ $t(''f<i'') }}j'
  ]],
  false
)

require('plugins')
vim.g.mapleader = " "
