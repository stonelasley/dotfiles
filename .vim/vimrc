"/* ======================== Settings ========================= */
set nocompatible
set relativenumber
set number
set smartindent
set ts=4 sw=2 et
set t_Co=256
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
filetype plugin indent on

"/* ---------------------- Directories ------------------------ */
set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/swap//

"/* ======================== Mappings ========================= */
:imap jk <Esc>
let mapleader="\<Space>"

nnoremap <Space> <Nop>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"/* ------------------Window Movement ------------------------ */
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

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
    Plug 'chriskempson/base16-vim'
    Plug 'quramy/tsuquyomi'
    Plug 'prettier/vim-prettier', {
        \ 'do': 'yarn install',
        \ 'for': ['javascript', 'typescript', 'css', 'scss', 'less', 'json', 'graphql', 'markdown', 'vue']}
    Plug 'valloric/youcompleteme'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
call plug#end()

"/* ==================== Plugin Settings ====================== */

"/* ------------------------- CtrlP --------------------------- */
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

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
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
highlight SyntasticErrorSign guifg=#af00ff guibg=#ff0000
highlight SyntasticErrorLine guibg=#0000af

"/* ---------------------- Tsuquyomi ------------------------- */
let g:syntastic_typescript_checkers = ['tslint','tsuquyomi']
let g:tsuquyomi_disable_quickfix = 1
let g:tsuquyomi_shortest_import_path = 1
let g:tsuquyomi_single_quote_import = 1
let g:tsuquyomi_completion_detail = 1
nnoremap <Leader>i :TsuImport<CR>
nnoremap <Leader>r :TsuRenameSymbol<CR>
nnoremap <Leader>d :TsuDefinition<CR>

"/* ---------------------- Nerd Tree ------------------------- */
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeMapJumpPrevSibling='<Nop>'
let g:NERDTreeMapJumpNextSibling='<Nop>'

"/* ---------------------- UltiSnips -------------------------- */
let g:UltiSnipsExpandTrigger="<C-e>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

" Prevent UltiSnips from removing mappings
let g:UltiSnipsMappingsToIgnore = ['autocomplete']

"/* -------------------- YouCompleteMe ------------------------ */
let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
let g:ycm_key_list_accept_completion = ['<C-y>']
"
"/* ---------------------- Prettier --------------------------- */
let g:prettier#config#print_width=80
let g:prettier#config#single_quote ='true'
let g:prettier#config#arrow_parens ='always'
let g:prettier#config#trailing_comma ='always'

"/* --------------------- Color Scheme ------------------------ */
colorscheme base16-default-dark 

"/* -------------------- AirLine Theme ------------------------ */
let g:airline_theme='base16'

