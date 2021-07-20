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
    config = [[require('mappings.nvim-tree')]]
  }
  use 'nvim-telescope/telescope-fzy-native.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
    config = function()
      require('mappings.telescope')
      require('config.telescope')
    end
  }

  -- Movement
  use {
    'phaazon/hop.nvim',
    as = 'hop',
    config = function() 
      require('config.hop')
      require('mappings.hop')
    end
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
      'ts',
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
    config = [[require('mappings.coc-prettier')]]
  }
  use { 
    'neoclide/coc-eslint', 
    run = 'yarn install --frozen-lockfile', 
    ft = { 'javascript', 'ts' },
    requires = { { 'neoclide/coc.nvim' } },
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
    config = function ()
      require('config.coc')
      require('mappings.coc')
    end
  }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

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
  use { 'wsdjeg/luarefvim', ft = 'lua'}

  -- vue
  use { 'posva/vim-vue', ft = { 'ts', 'vue' } }
  use { 
    'neoclide/coc-vetur',
    run = 'yarn install --frozen-lockfile',
    requires = { { 'neoclide/coc.nvim' } },
  }

  -- typescript
  use 'leafgarland/typescript-vim'
  use { 'neoclide/coc-tsserver', run = 'yarn install --frozen-lockfile'}

  -- vimscript
  use { 'iamcco/coc-vimlsp', ft = { 'vim' } }

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
