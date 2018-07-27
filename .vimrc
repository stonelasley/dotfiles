"/* ======================== Settings ========================= */
set nocompatible
set relativenumber
set number
set smartindent
set ts=4 sw=2 et
set t_Co=256
filetype plugin indent on
set statusline+=%F

"/* ======================== Mappings ========================= */
:imap jk <Esc>
let mapleader="\<Space>"
nnoremap <Space> <Nop>

"/* ------------------Window Movement ------------------------ */
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"/* ================= Vim Plug Auto Install =================== */
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"/* ======================== Plugins ========================== */
call plug#begin('~/.vim/plugged')
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'flazz/vim-colorschemes'
    Plug 'easymotion/vim-easymotion'
    Plug 'yggdroot/indentline'
    Plug 'vim-syntastic/syntastic'
    Plug 'leafgarland/typescript-vim'
    Plug 'hzchirs/vim-material'
    Plug 'scrooloose/nerdtree'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'quramy/tsuquyomi'
    Plug 'prettier/vim-prettier', {
        \ 'do': 'yarn install',
        \ 'for': ['javascript', 'typescript', 'css', 'scss', 'less', 'json', 'graphql', 'markdown', 'vue']}
call plug#end()

"/* ==================== Plugin Settings ====================== */

"/* ------------------------- CtrlP --------------------------- */
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

"/* ---------------------- EasyMotion ------------------------- */
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

"/* -------------------- Indent Guides ----------------------- */
let g:indentLine_color_term = 239

"/* ---------------------- Syntastic ------------------------- */
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"let g:syntastic_typescript_checkers = ['tsc', 'tslint']
let g:syntastic_typescript_checkers = ['tsuquyomi']
let g:tsuquyomi_disable_quickfix = 1

"/* ---------------------- Nerd Tree ------------------------- */
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeMapJumpPrevSibling='<Nop>'
let g:NERDTreeMapJumpNextSibling='<Nop>'

"/* ---------------------- UltiSnips -------------------------- */
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
"/* -------------------- Color Scheme ------------------------ */
set t_Co=256
set background=dark
colorscheme molokai 

