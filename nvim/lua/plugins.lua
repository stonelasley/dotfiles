local packer = nil

local function init()
  if packer == nil then
    packer = require'packer'
    packer.init { disable_commands = true }
  end

 local use = packer.use

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
 use  {
   'yggdroot/indentline',
   config = [[require('config.indentguides')]]
 }

 --  -- Searching & Finding
 use 'wincent/loupe'
 use {
   'kyazdani42/nvim-tree.lua',
   requires = { { 'kyazdani42/nvim-web-devicons' } },
   setup = [[require('mappings.nvim-tree')]]
 }
 use 'nvim-telescope/telescope-fzy-native.nvim'
 use {
   'nvim-telescope/telescope-frecency.nvim',
   requires = { { 'tami5/sql.nvim' } },
 }
 use {
   'nvim-telescope/telescope.nvim',
   requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
   setup = [[require('mappings.telescope')]],
   config = [[require('config.telescope')]]
 }

 -- Completion
 use {
   'hrsh7th/nvim-compe',
   setup = [[require('mappings.compe')]],
   config = [[require('config.compe')]]
 }
 -- TODO temporary until I decide how to address c# completion
 use {
   'shougo/deoplete.nvim',
   ft = 'cs',
   config = [[require('config.deoplete')]],
   run = ':UpdateRemotePlugins'
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
   setup = [[require('mappings.prettier')]],
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
   config = [[require('config.lspsaga')]],
   setup = [[require('mappings.lspsaga')]]
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
   config = [[require('config.trouble')]],
   setup = [[require('mappings.trouble')]],
 }

 -- C#
 use {
   'omnisharp/omnisharp-vim',
   config = [[require('config.omnisharp')]],
   --setup = [[require('mappings.omnisharp')]],
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

 use {
   'stonelasley/kartograaf.nvim',
   opt = false
 }
end



local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins
