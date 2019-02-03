execute pathogen#infect()
"/* ======================== Settings ========================= */
set nocompatible
set relativenumber
set number
set smartindent
"set tabstop=8
"set shiftwidth=4
set expandtab
set autoindent

syntax on

filetype plugin on

"/* ---------------------- Directories ------------------------ */
set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/swap//

"/* ----------------------- Plugins --------------------------- */
call plug#begin('~/.vim/plugged')
        Plug 'airblade/vim-gitgutter'
        Plug 'chriskempson/base16-vim'
        Plug 'easymotion/vim-easymotion'
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': '.install --all' }
        Plug 'junegunn/fzf.vim'
        Plug 'honza/vim-snippets'
        Plug 'leafgarland/typescript-vim',{ 'for', 'typescript' }
        Plug 'prettier/vim-prettier', {
            \ 'do': 'yarn install',
            \ 'for': ['typescript', 'javascript', 'css', 'scss', 'json'] }
        Plug 'quramy/tsuquyomi', { 'for', 'typescript' }
        Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle'}
        Plug 'SirVer/ultisnips'
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

