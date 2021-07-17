vim.api.nvim_command('let &packpath = &runtimepath')
require('mappings')
require('settings')
require('plugins')
require('config.coc')
require('config.telescope')
require('config.nvim-tree')
require('config.hop')

-- AutoCommands
-- au! BufWritePost $MYVIMRC source %

-- Highlight text on yank
vim.api.nvim_command("au TextYankPost * silent! lua require'vim.highlight'.on_yank()")
