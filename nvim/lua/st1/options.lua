local cmd = vim.cmd
local utils = require('utils')

cmd([[
  let &packpath = &runtimepath
  set rtp+=/opt/fzf
  set ffs=unix,dos
  set ff=unix
]])

utils.opt({ 'o', 'b' }, 'expandtab', true)
utils.opt({ 'o', 'b' }, 'smartindent', true)
utils.opt({ 'o', 'b' }, 'textwidth', 100)
utils.opt({ 'o', 'w' }, 'number', true)
utils.opt({ 'o', 'w' }, 'relativenumber', true)
utils.opt('o', 'splitbelow', true)
utils.opt('o', 'splitright', true)
utils.opt('w', 'wrap', false)
utils.opt('o', 'formatoptions', 'cro')
utils.opt('o', 'termguicolors', true)

vim.opt.clipboard:append('unnamedplus')
vim.g.indentLine_fileTypeExclude = { 'json' }
vim.g.wrap = false
vim.g.ttimeoutlen = 100
vim.g.guicursor = 'blinkon100'
vim.o.completeopt = 'menuone,preview,noinsert'
