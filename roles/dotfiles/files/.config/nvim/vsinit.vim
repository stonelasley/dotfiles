if exists('g:vscode')
  "let mapleader="\<Space>"
  nnoremap <silent> <leader>a :ArgWrap<CR>
  nnoremap <Space> <Nop>
  "/* ---------------------- Vim Commentary ------------------------ */
  xmap gc  <Plug>VSCodeCommentary
  nmap gc  <Plug>VSCodeCommentary
  omap gc  <Plug>VSCodeCommentary
  nmap gcc <Plug>VSCodeCommentaryLine

  "/* ---------------------- Window Movement ------------------------ */
  nnoremap <C-l> <Cmd>call VSCodeNotify('workbench.action.navigateRight')<CR>
  xnoremap <C-l> <Cmd>call VSCodeNotify('workbench.action.navigateRight')<CR>
  nnoremap <C-h> <Cmd>call VSCodeNotify('workbench.action.navigateLeft')<CR>
  xnoremap <C-h> <Cmd>call VSCodeNotify('workbench.action.navigateLeft')<CR>
  nnoremap <C-k> <Cmd>call VSCodeNotify('workbench.action.navigateUp')<CR>
  xnoremap <C-k> <Cmd>call VSCodeNotify('workbench.action.navigateUp')<CR>
  nnoremap <C-j> <Cmd>call VSCodeNotify('workbench.action.navigateDown')<CR>
  xnoremap <C-j> <Cmd>call VSCodeNotify('workbench.action.navigateDown')<CR>

  nnoremap <C-o> <Cmd>call VSCodeNotify('workbench.action.navigateBack')<CR>
  nnoremap <C-i> <Cmd>call VSCodeNotify('workbench.action.navigateForward')<CR>

  nnoremap <C-r><C-r> <Cmd>call VSCodeNotify('editor.action.rename')<CR>
  xnoremap <C-r><C-r> <Cmd>call VSCodeNotify('editor.action.rename')<CR>
  nnoremap <C-r><C-s> <Cmd>call VSCodeNotify('editor.action.onTypeRename')<CR>
  xnoremap <C-r><C-s> <Cmd>call VSCodeNotify('editor.action.onTypeRename')<CR>

  nnoremap <g-d> <Cmd>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>
  xnoremap <g-d> <Cmd>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>
  nnoremap <g-i> <Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>
  xnoremap <g-i> <Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>

  " <Leader>f{char} to move to {char}
  map  <Leader>f <Plug>(easymotion-bd-f)
  nmap <Leader>f <Plug>(easymotion-overwin-f)
  
  " s{char}{char} to move to {char}{char}
  nmap s <Plug>(easymotion-overwin-f2)
  
  " Move to line
  map <Leader>L <Plug>(easymotion-bd-jk)
  nmap <Leader>L <Plug>(easymotion-overwin-line)
  "
  " Move to word
  map  <Leader>w <Plug>(easymotion-bd-w)
  nmap <Leader>w <Plug>(easymotion-overwin-w)
endif
"/* ---------------------- Vim Commentary ------------------------ */
call plug#begin('~/.config/nvim/vscode/vs-plugged')
  Plug 'tpope/vim-surround'
  Plug 'asvetliakov/vim-easymotion'
  Plug 'foosoft/vim-argwrap'
call plug#end()

"/* ---------------------- AutoCommands ------------------------ */
au TextYankPost * silent! lua require'vim.highlight'.on_yank()
