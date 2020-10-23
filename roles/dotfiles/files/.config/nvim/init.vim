set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" TODO pull appropriate settings out of this check as tested
if !exists('g:vscode')
        source ~/.vimrc
endif
