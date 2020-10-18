execute pathogen#infect()

"/* ======================== Settings ========================= */
set nocompatible
set relativenumber
set number
set splitbelow
set splitright
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
        Plug 'christoomey/vim-tmux-navigator'
        Plug 'dhruvasagar/vim-zoom'
        Plug 'easymotion/vim-easymotion'
        Plug 'jiangmiao/auto-pairs'
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': '.install --all' }
        Plug 'junegunn/fzf.vim'
        Plug 'leafgarland/typescript-vim'
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'iamcco/coc-vimlsp'
        Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
        Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile' }
        Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile' }
        Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile' }
        Plug 'neoclide/coc-vetur', {'do': 'yarn install --frozen-lockfile' }
        Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile' }
        Plug 'posva/vim-vue'
        Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle'}
        Plug 'mhartington/oceanic-next'
        Plug 'tpope/vim-commentary'
        Plug 'tpope/vim-eunuch'
        Plug 'tpope/vim-fugitive'
        Plug 'tpope/vim-projectionist'
        Plug 'tpope/vim-surround'
        Plug 'tpope/vim-sensible'
        Plug 'tpope/vim-sleuth'
        Plug 'vim-airline/vim-airline'
        Plug 'wincent/ferret'
        Plug 'wincent/loupe'
        Plug 'yggdroot/indentline'
call plug#end()

"/* ---------------------- QOL ------------------------ */
au! BufWritePost $MYVIMRC source %


