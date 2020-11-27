set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
"/* ---------------------- AutoCommands ------------------------ */
"  au! BufWritePost $MYVIMRC source %
"/* ---------------------- AutoCommands ------------------------ */
au TextYankPost * silent! lua require'vim.highlight'.on_yank()
