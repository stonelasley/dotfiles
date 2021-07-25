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
  use  {
    'yggdroot/indentline',
    config = [[require('config.indentguides')]]
  }

  -- Searching & Finding
  use 'wincent/ferret'
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

  -- Movement
  use {
    'phaazon/hop.nvim',
    as = 'hop',
    setup = [[require('mappings.hop')]],
    config = [[require('config.hop')]]
  }
  use 'christoomey/vim-tmux-navigator'
  use 'dhruvasagar/vim-zoom'

  -- Git
  use 'tpope/vim-fugitive'

  -- Linting
  use { 
    'neoclide/coc-prettier',
    run = 'yarn install --frozen-lockfile',
    ft = { 
      'javascript',
      'typescript',
      'css',
      'less',
      'scss',
      'json',
      'html',
      'md',
      'vue',
      'yaml'
    },
    requires = { { 'neoclide/coc.nvim' } },
    setup = [[require('mappings.coc-prettier')]]
  }
  use { 
    'neoclide/coc-eslint', 
    run = 'yarn install --frozen-lockfile', 
    ft = { 'javascript', 'typescript' },
    requires = { { 'neoclide/coc.nvim' } },
  }
  use {
    'fannheyward/coc-markdownlint',
    ft = { 'md' }
  }

  -- Snippets
  use 'honza/vim-snippets'
  use { 
    'neoclide/coc-snippets', 
    run = 'yarn install --frozen-lockfile' ,
    requires = { { 'neoclide/coc.nvim' } },
  }

  -- Languages
  use { 
    'neoclide/coc.nvim',
    branch = 'release' ,
    setup = [[require('mappings.coc')]],
    config = [[require('config.coc')]]
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

  -- html & json
  use { 
    'neoclide/coc-json',
    run = 'yarn install --frozen-lockfile',
    ft = { 'json' },
    requires = { { 'neoclide/coc.nvim' } },
  }
  use { 
    'neoclide/coc-html',
    run = 'yarn install --frozen-lockfile',
    ft = { 'html' },
    requires = { { 'neoclide/coc.nvim' } },
  }

  -- lua
  use { 'euclidianace/betterlua.vim', ft = { 'lua' } }
  use 'rafcamlet/nvim-luapad'

  -- vue
  use { 'posva/vim-vue', ft = { 'typescript', 'vue' } }
  use { 
    'neoclide/coc-vetur',
    run = 'yarn install --frozen-lockfile',
    requires = { { 'neoclide/coc.nvim' } },
  }

  -- typescript
  use {
    'leafgarland/typescript-vim',
    config = [[require('config.typescript')]],
    ft = { 'typescript' }
  }
  use { 'neoclide/coc-tsserver', run = 'yarn install --frozen-lockfile'}

  -- vimscript
  use { 
    'iamcco/coc-vimlsp',
    requires = { { 'neoclide/coc.nvim' } },
    ft = { 'vim' } }

  -- Themes
  use 'vim-airline/vim-airline'
  use 'mhartington/oceanic-next'
  
  -- Notes
  use {
    'vimwiki/vimwiki',
    config = [[require('config.vimwiki')]]
  }
end


local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins
