"let &packpath = &runtimepath
:lua require('mappings')
:lua require('mappings.normal')
:lua require('settings')
:lua require('plugins.coc')

call plug#begin('~/.config/nvim/plugged')
        Plug 'christoomey/vim-tmux-navigator'
        Plug 'dhruvasagar/vim-zoom'
        Plug 'easymotion/vim-easymotion'
        Plug 'jiangmiao/auto-pairs'
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': '.install --all' }
        Plug 'junegunn/fzf.vim'
        Plug 'leafgarland/typescript-vim'
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'honza/vim-snippets'
        Plug 'iamcco/coc-vimlsp'
        Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
        Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile' }
        Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile' }
        Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile' }
        Plug 'neoclide/coc-vetur', {'do': 'yarn install --frozen-lockfile' }
        Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile' }
        Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile' }
        Plug 'posva/vim-vue'
        "Plug 'sirver/ultisnips'
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
        Plug 'git@github.com:stonelasley/taskr.git'
        Plug 'rafcamlet/nvim-luapad'
call plug#end()

"/* ---------------------- AutoCommands ------------------------ */
"  au! BufWritePost $MYVIMRC source %
"/* ---------------------- AutoCommands ------------------------ */
au TextYankPost * silent! lua require'vim.highlight'.on_yank()
