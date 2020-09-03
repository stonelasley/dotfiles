execute pathogen#infect()

"/* ======================== Settings ========================= */
set encoding=utf-8
set nocompatible
set relativenumber
set number
set splitbelow
set splitright
set expandtab
set smarttab
set autoindent
set smartindent
set nowrap
set iskeyword+=-
set formatoptions-=cro

syntax on

filetype plugin on

"/* ---------------------- Directories ------------------------ */
set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/swap//

"/* ----------------------- Plugins --------------------------- */
call plug#begin('~/.vim/plugged')
        Plug 'arcticicestudio/nord-vim'
        Plug 'christoomey/vim-tmux-navigator'
        Plug 'dhruvasagar/vim-zoom'
        Plug 'easymotion/vim-easymotion'
        Plug 'jiangmiao/auto-pairs'
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': '.install --all' }
        Plug 'junegunn/fzf.vim'
        Plug 'leafgarland/typescript-vim', { 'for': [ 'typescript', 'vue' ] }
        Plug 'machakann/vim-highlightedyank'
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'iamcco/coc-vimlsp'
        Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
        Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile', 'for': ['json']}
        Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile', 'for': ['html', 'vue']}
        Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile', 'for': ['typescript', 'javascript', 'vue']}
        Plug 'neoclide/coc-vetur', {'do': 'yarn install --frozen-lockfile', 'for': ['vue']}
        Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile', 'for': ['typescript', 'javascript', 'vue']}
        Plug 'posva/vim-vue', { 'for': 'vue' }
        Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle'}
        Plug 'tpope/vim-commentary'
        Plug 'tpope/vim-eunuch'
        Plug 'tpope/vim-fugitive'
        Plug 'tpope/vim-projectionist'
        Plug 'tpope/vim-surround'
        Plug 'vim-airline/vim-airline'
        Plug 'wincent/ferret'
        Plug 'wincent/loupe'
        Plug 'yggdroot/indentline'
call plug#end()

"/* ---------------------- QOL ------------------------ */
au! BufWritePost $MYVIMRC source %


