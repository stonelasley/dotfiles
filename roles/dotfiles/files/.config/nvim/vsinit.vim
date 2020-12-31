set runtimepath^=~/.config/nvim/.vsvim runtimepath+=~/.vim/after
let &packpath = &runtimepath

if exists('g:vscode')
  "let mapleader="\<Space>"
  nnoremap <silent> <leader>a :ArgWrap<CR>
  nnoremap <Space> <Nop>

  nnoremap gg <Cmd>call VSCodeNotify('cursorTop')<CR>
  xnoremap gg <Cmd>call VSCodeNotify('cursorTop')<CR>

  "/* ---------------------- Vim Commentary ------------------------ */
  xmap gc  <Plug>VSCodeCommentary
  nmap gc  <Plug>VSCodeCommentary
  omap gc  <Plug>VSCodeCommentary
  nmap gcc <Plug>VSCodeCommentaryLine

  nnoremap <C-r><C-r> <Cmd>call VSCodeNotify('editor.action.rename')<CR>
  xnoremap <C-r><C-r> <Cmd>call VSCodeNotify('editor.action.rename')<CR>
  nnoremap <C-r><C-s> <Cmd>call VSCodeNotify('editor.action.onTypeRename')<CR>
  xnoremap <C-r><C-s> <Cmd>call VSCodeNotify('editor.action.onTypeRename')<CR>

  nnoremap <g-d> <Cmd>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>
  xnoremap <g-d> <Cmd>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>
  nnoremap <g-i> <Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>
  xnoremap <g-i> <Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>

  "/* ---------------------- Faux Ferret --------------------------------*/
  command! -bang Ack call VSCodeNotify('workbench.view.search')
  command! -bang Acks call VSCodeNotify('workbench.action.replaceInFiles')
endif
"/* ---------------------- Vim Commentary ------------------------ */
call plug#begin('~/.config/nvim/vscode/vs-plugged')
  Plug 'tpope/vim-surround'
  Plug 'asvetliakov/vim-easymotion'
  Plug 'foosoft/vim-argwrap'
call plug#end()

"/* ---------------------- AutoCommands ------------------------ */
au TextYankPost * silent! lua require'vim.highlight'.on_yank()
