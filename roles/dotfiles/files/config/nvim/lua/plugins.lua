local packer = nil

local function init() 
  if packer == nil then
    packer = require'packer'
    packer.init { disable_commands = true }

  end

  local use = packer.use

  use 'wbthomason/packer.nvim'

  -- Convenience Utilities
  use 'tpope/vim-sensible'
  use 'tpope/vim-sleuth'
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'tpope/vim-eunuch'
  use 'tpope/vim-projectionist'
  use 'jiangmiao/auto-pairs'
  use 'yggdroot/indentline'

  -- Searching & Finding
  use 'wincent/ferret'
  use 'wincent/loupe'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = { { 'kyazdani42/nvim-web-devicons' } },
  }
  use 'nvim-telescope/telescope-fzy-native.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
    setup = [[require('mappings.telescope')]],
    config = [[require('config.telescope')]]
    --cmd = 'Telescope'
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
  -- use { 'neoclide/coc-prettier', run = 'yarn install --frozen-lockfile' }
  -- use { 'neoclide/coc-eslint', run = 'yarn install --frozen-lockfile' }

  -- Snippets
  use 'honza/vim-snippets'
  -- use { 'neoclide/coc-snippets', run = 'yarn install --frozen-lockfile' }

  -- Languages
  -- use { 'neoclide/coc.nvim', branch = 'release' }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- html & json
  -- use { 'neoclide/coc-json', run = 'yarn install --frozen-lockfile' }
  -- use { 'neoclide/coc-html', run = 'yarn install --frozen-lockfile' }

  -- lua
  use { 'euclidianace/betterlua.vim', ft = { 'lua' } }
  use 'rafcamlet/nvim-luapad'

  -- vue
  use { 'posva/vim-vue', ft = { 'ts', 'vue' } }
  -- use { 'neoclide/coc-vetur', run = 'yarn install --frozen-lockfile' }

  -- typescript
  use 'leafgarland/typescript-vim'
  -- use { 'neoclide/coc-tsserver', run = 'yarn install --frozen-lockfile'}

  -- vimscript
  -- use { 'iamcco/coc-vimlsp', ft = { 'vim' } }

  -- Themes
  use 'vim-airline/vim-airline'
  use 'mhartington/oceanic-next'
end


local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins
