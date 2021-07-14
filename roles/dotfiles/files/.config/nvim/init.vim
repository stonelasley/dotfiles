let &packpath = &runtimepath
:lua require('mappings')
:lua require('mappings.normal')
:lua require('settings')
:lua require('plugins.coc')
:lua require('plugins')

call plug#begin('~/.config/nvim/plugged')
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': '.install --all' }
        Plug 'junegunn/fzf.vim'
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
        Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile' }
        Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile' }
        Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile' }
        Plug 'neoclide/coc-vetur', {'do': 'yarn install --frozen-lockfile' }
        Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile' }
        Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile' }
        Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle'}
        Plug 'git@github.com:stonelasley/taskr.git'
call plug#end()

"/* ---------------------- AutoCommands ------------------------ */
"  au! BufWritePost $MYVIMRC source %
"/* ---------------------- AutoCommands ------------------------ */
au TextYankPost * silent! lua require'vim.highlight'.on_yank()
