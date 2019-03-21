execute pathogen#infect()
"/* ======================== Settings ========================= */
set nocompatible
set relativenumber
set number
set expandtab
set foldlevel=1

syntax on

filetype plugin on


"/* ---------------------- Directories ------------------------ */
set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/swap//

"/* ----------------------- Plugins --------------------------- */
call plug#begin('~/.vim/plugged')
        Plug 'ap/vim-css-color', {'for': ['css', 'scss', 'vue']}
        Plug 'airblade/vim-gitgutter'
        Plug 'chriskempson/base16-vim'
        Plug 'christoomey/vim-tmux-navigator'
        Plug 'easymotion/vim-easymotion'
        Plug 'jiangmiao/auto-pairs'
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': '.install --all' }
        Plug 'junegunn/fzf.vim'
        Plug 'junegunn/rainbow_parentheses.vim', {'for': ['typescript', 'javascript', 'vue']}
        Plug 'honza/vim-snippets'
        Plug 'mattn/emmet-vim', { 'for': ['html', 'vue'] }
        Plug 'leafgarland/typescript-vim', { 'for': [ 'typescript', 'vue' ] }
        Plug 'posva/vim-vue', { 'for': 'vue' }
        Plug 'prettier/vim-prettier', { 'for': ['typescript', 'javascript', 'css', 'scss', 'json', 'vue'] }
        Plug 'quramy/tsuquyomi', { 'for': ['typescript', 'vue'] }
        Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle'}
        Plug 'SirVer/ultisnips'
        Plug 'tpope/vim-sensible'
        Plug 'tpope/vim-eunuch'
        Plug 'tpope/vim-fugitive'
        Plug 'tpope/vim-projectionist'
        Plug 'tpope/vim-surround'
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
        Plug 'vim-syntastic/syntastic'
        Plug 'wincent/ferret'
        Plug 'wincent/loupe'
        Plug 'yggdroot/indentline'
call plug#end()
