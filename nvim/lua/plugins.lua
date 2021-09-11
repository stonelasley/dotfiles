vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
 use 'wbthomason/packer.nvim'

 -- Convenience Utilities
 use 'lionc/nest.nvim'
 use 'tpope/vim-sensible'
 use 'tpope/vim-sleuth'
 use 'tpope/vim-surround'
 use 'tpope/vim-commentary'
 use 'tpope/vim-eunuch'
 use 'tpope/vim-projectionist'
 use 'andrewradev/splitjoin.vim'
 use {
   'windwp/nvim-autopairs' ,
   config = [[require('config.autopairs')]]
 }
 use {
   'lukas-reineke/indent-blankline.nvim',
   config = [[require('config.indentguides')]]
 }

 --  -- Searching & Finding
 use 'wincent/loupe'
 use {
   'kyazdani42/nvim-tree.lua',
   requires = { { 'kyazdani42/nvim-web-devicons' } },
   cmd = 'NvimTreeToggle'
 }
 use 'nvim-telescope/telescope-fzy-native.nvim'
 use {
   'nvim-telescope/telescope-frecency.nvim',
   requires = { { 'tami5/sql.nvim' } }
 }
 use {
   'nvim-telescope/telescope.nvim',
   requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
   config = [[require('config.telescope')]],
   cmd = 'Telescope'
 }

 -- Completion
 use {
   'hrsh7th/nvim-compe',
   config = [[require('config.compe')]]
 }
 -- TODO temporary until I decide how to address c# completion
 use {
   'shougo/deoplete.nvim',
   config = [[require('config.deoplete')]],
   run = ':UpdateRemotePlugins',
   ft = 'cs'
 }
 use {
   'junegunn/fzf.vim',
   ft = 'cs'
 }

 -- Movement
 use {
   'phaazon/hop.nvim',
   as = 'hop',
   config = [[require('config.hop')]]
 }
 use 'christoomey/vim-tmux-navigator'
 use 'dhruvasagar/vim-zoom'

 -- Git
 use 'tpope/vim-fugitive'

 -- Linting
 use {
   'prettier/vim-prettier',
   run = 'yarn install',
   ft = {
     'css',
     'html',
     'javascript',
     'scss',
     'typescript',
     'vue'
   }
 }
 use {
   'dense-analysis/ale',
   config = [[require('config.ale')]],
   ft = 'cs'
 }

 -- Snippets
 use {
   'sirver/ultisnips',
   config = [[require('config.ultisnips')]]
 }
 use { 'honza/vim-snippets' }
 use { 'hrsh7th/vim-vsnip' }
 use { 'softchris/ts-snippets' }

 -- Languages
 use {
   'neovim/nvim-lspconfig',
   config = [[require('config.lsp')]]
 }
 use {
   'glepnir/lspsaga.nvim',
   config = [[require('config.lspsaga')]]
 }
 use {
   'nvim-treesitter/nvim-treesitter',
   run = ':TSUpdate',
   config = [[require('config.treesitter')]]
 }
 use {
   'nvim-treesitter/playground',
   requires = { { 'nvim-treesitter/nvim-treesitter' } },
   config = [[require('config.treesitterplayground')]],
   cmd = 'TSPlaygroundToggle'
 }
 use {
   "folke/trouble.nvim",
   requires = "kyazdani42/nvim-web-devicons",
   config = [[require('config.trouble')]]
 }

 -- C#
 use {
   'omnisharp/omnisharp-vim',
   config = [[require('config.omnisharp')]],
   ft = { 'cs'}
 }

 -- lua
 use { 'euclidianace/betterlua.vim', ft = { 'lua' } }
 use 'rafcamlet/nvim-luapad'

 -- vue
 use { 'posva/vim-vue', ft = { 'typescript', 'vue' } }

 -- typescript
 use {
   'leafgarland/typescript-vim',
   config = [[require('config.typescript')]]
 }

 -- Themes
 use {
   'hoob3rt/lualine.nvim',
   requires = { { 'kyazdani42/nvim-web-devicons' } },
   config = [[require('config.lualine')]]
 }
 use {
   'onsails/lspkind-nvim',
   config = [[require('config.lspkind')]]
 }

 -- 'rafamadriz/neon',
 use {
   'stonelasley/neon',
   config = [[require('config.neon')]],
 }

 -- Notes
 use {
   'vimwiki/vimwiki',
   config = [[require('config.vimwiki')]]
 }

 -- Bindings
 use {
   'stonelasley/kartograaf.nvim',
   config = [[require('mappings')]],
   opt = false
 }

 use {
   'folke/which-key.nvim',
   config = [[require('config.whichkey')]]
 }
end)
