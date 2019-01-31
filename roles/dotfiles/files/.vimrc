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
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': '.install --all' }
        Plug 'junegunn/fzf.vim'
        Plug 'yggdroot/indentline'
        Plug 'scrooloose/nerdtree'
        Plug 'easymotion/vim-easymotion'
        Plug 'quramy/tsuquyomi'
        Plug 'vim-syntastic/syntastic'
        Plug 'SirVer/ultisnips'
        Plug 'honza/vim-snippets'
        Plug 'chriskempson/base16-vim'
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
        Plug 'leafgarland/typescript-vim'
        Plug 'prettier/vim-prettier', {
            \ 'do': 'yarn install',
            \ 'for': ['typescript', 'javascript', 'css', 'scss', 'json'] }
        Plug 'wincent/ferret'
        Plug 'wincent/loupe'
        Plug 'tpope/vim-eunuch'
        Plug 'tpope/vim-fugitive'
"        Plug 'tpope/vim-projectionist'
        Plug 'tpope/vim-surround'
        Plug 'airblade/vim-gitgutter'
call plug#end()

