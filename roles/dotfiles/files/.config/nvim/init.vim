set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
au TextYankPost * silent! lua require'vim.highlight'.on_yank()
