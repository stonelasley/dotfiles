nnoremap <Space> <Nop>

" Toggle fold under cursor
"nnoremap <Tab> za
nnoremap <C-=> zm
nnoremap <C--> zr

"/* ------------------ Window Movement ------------------------ */
nnoremap <C-l> <Cmd>call VSCodeNotify('workbench.action.navigateRight')<CR>
xnoremap <C-l> <Cmd>call VSCodeNotify('workbench.action.navigateRight')<CR>

nnoremap <C-h> <Cmd>call VSCodeNotify('workbench.action.navigateLeft')<CR>
xnoremap <C-h> <Cmd>call VSCodeNotify('workbench.action.navigateLeft')<CR>

nnoremap <C-k> <Cmd>call VSCodeNotify('workbench.action.navigateUp')<CR>
xnoremap <C-k> <Cmd>call VSCodeNotify('workbench.action.navigateUp')<CR>

nnoremap <C-j> <Cmd>call VSCodeNotify('workbench.action.navigateDown')<CR>
xnoremap <C-j> <Cmd>call VSCodeNotify('workbench.action.navigateDown')<CR>

"/* ------------------ Navigation ------------------------ */
nnoremap <C-o> <Cmd>call VSCodeNotify('workbench.action.navigateBack')<CR>
nnoremap <C-i> <Cmd>call VSCodeNotify('workbench.action.navigateForward')<CR>

"/* ------------------ Window Size ------------------------ */
nnoremap <M-j> :resize-2
nnoremap <M-k> :resize+2
nnoremap <M-h> :vertical resize-2
nnoremap <M-l> :vertical resize+2

nnoremap <leader>ls :ls<CR>:b<space>

" Turn off highlighting until next search
nnoremap <CR> :noh<CR><CR>

cmap w!! w !sudo tee %

" Replace current word
:nnoremap <Leader>rr :%s/\<C-r><C-w>/
