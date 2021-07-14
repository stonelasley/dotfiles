return require('packer').startup(function(use)
	use 'christoomey/vim-tmux-navigator'
	use 'dhruvasagar/vim-zoom'
	use 'easymotion/vim-easymotion'
	use 'jiangmiao/auto-pairs'
	-- --use 'junegunn/fzf', { 'dir': '~/.fzf', 'do': '.install --all' }
	-- use 'junegunn/fzf.vim'
	use 'leafgarland/typescript-vim'
	-- --use 'neoclide/coc.nvim', {'branch': 'release'}
	use 'honza/vim-snippets'
	use 'iamcco/coc-vimlsp'
	-- --use 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
	-- --use 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile' }
	-- --use 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile' }
	-- --use 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile' }
	-- --use 'neoclide/coc-vetur', {'do': 'yarn install --frozen-lockfile' }
	-- --use 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile' }
	-- --use 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile' }
	use 'posva/vim-vue'
	-- use 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle'}
	use 'mhartington/oceanic-next'
	use 'tpope/vim-commentary'
	use 'tpope/vim-eunuch'
	use 'tpope/vim-fugitive'
	use 'tpope/vim-projectionist'
	use 'tpope/vim-surround'
	use 'tpope/vim-sensible'
	use 'tpope/vim-sleuth'
	use 'vim-airline/vim-airline'
	use 'wincent/ferret'
	use 'wincent/loupe'
	use 'yggdroot/indentline'
	-- --use 'git@github.com:stonelasley/taskr.git'
	use 'rafcamlet/nvim-luapad'
end)
