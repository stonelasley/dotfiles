vim.api.nvim_command('let &packpath = &runtimepath')
require('plugins')
require('mappings')
require('config')

-- AutoCommands
-- au! BufWritePost $MYVIMRC source %

-- Highlight text on yank
vim.api.nvim_command("au TextYankPost * silent! lua require'vim.highlight'.on_yank()")
