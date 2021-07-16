vim.api.nvim_command('let &packpath = &runtimepath')
require('mappings')
require('mappings.normal')
require('settings')
require('plugins')
require('config.coc')
require('config.telescope')
require('config.nvim-tree')
require('config.hop')

-- AutoCommands
-- au! BufWritePost $MYVIMRC source %
-- au TextYankPost * silent! lua require'vim.highlight'.on_yank()
vim.api.nvim_command("au TextYankPost * silent! lua require'vim.highlight'.on_yank()")
