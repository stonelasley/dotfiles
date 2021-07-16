let &packpath = &runtimepath
:lua require('mappings')
":lua require('mappings.normal')
:lua require('settings')
:lua require('plugins')

"/* ---------------------- AutoCommands ------------------------ */
"  au! BufWritePost $MYVIMRC source %
"/* ---------------------- AutoCommands ------------------------ */
au TextYankPost * silent! lua require'vim.highlight'.on_yank()
