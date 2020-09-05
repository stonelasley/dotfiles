:imap jk <Esc>

nnoremap <Space> <Nop>

" Toggle fold under cursor
"nnoremap <Tab> za
nnoremap <C-=> za
nnoremap <C--> za

"/* ------------------Window Movement ------------------------ */
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"/* ------------------Window Size ------------------------ */
nnoremap <M-j> :resize-2
nnoremap <M-k> :resize+2
nnoremap <M-h> :vertical resize-2
nnoremap <M-l> :vertical resize+2

nnoremap <leader>ls :ls<CR>:b<space>

" Turn off highlighting until next search
nnoremap <CR> :noh<CR><CR>

cmap w!! w !sudo tee %

