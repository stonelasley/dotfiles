local cmd = vim.cmd
local utils = require('utils')

local backupdir = vim.fn.expand('~/.config/nvim/backup//')
local swapdir = vim.fn.expand('~/.config/nvim/swap//')

vim.api.nvim_command('let &packpath = &runtimepath')

require('plugins')
require('mappings')

utils.opt({'o', 'b'}, 'expandtab', true)
utils.opt({'o', 'b'}, 'smartindent', true)
utils.opt({'o', 'b'}, 'textwidth', 100)
utils.opt({'o', 'w'}, 'number', true)
utils.opt({'o', 'w'}, 'relativenumber', true)
utils.opt('o', 'splitbelow', true)
utils.opt('o', 'splitright', true)
utils.opt('w', 'wrap', false)
utils.opt('o', 'formatoptions', 'cro')
utils.opt('o', 'backupdir', backupdir) -- keep backup files out of the way (ie. if 'backup' is ever set)
utils.opt('o', 'directory', swapdir)   -- keep swap files out of the way
vim.cmd('set foldmethod=syntax')

vim.opt.clipboard:append("unnamedplus")
vim.g.indentLine_fileTypeExclude = {'json'}
vim.g.wrap = false
vim.o.termguicolors = true

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

-- Packer
cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
cmd [[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
cmd [[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
cmd [[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]]
