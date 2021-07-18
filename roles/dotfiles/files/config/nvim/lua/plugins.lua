local packer = nil

local function init() 
  if packer == nil then
    packer = require'packer'
    packer.init { disable_commands = true }

  end

  local use = packer.use

  use 'wbthomason/packer.nvim'
  use 'christoomey/vim-tmux-navigator'
  use 'dhruvasagar/vim-zoom'
  use {
    'phaazon/hop.nvim',
    as = 'hop',
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      -- require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }
  use 'jiangmiao/auto-pairs'
  use 'nvim-telescope/telescope-fzy-native.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
    setup = function() 
      require('telescope').setup {
        extensions = {
          fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true
          }
        }
      }
      require('telescope').load_extension('fzy_native')
    end
    --config = [[require('config.telescope')]],
    --cmd = 'Telescope'
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = { { 'kyazdani42/nvim-web-devicons' } },
  }
  use 'leafgarland/typescript-vim'
  use 'honza/vim-snippets'
  use 'iamcco/coc-vimlsp'
  use { 'neoclide/coc.nvim', branch = 'release' }
  use { 'neoclide/coc-tsserver', run = 'yarn install --frozen-lockfile'}
  use { 'neoclide/coc-json', run = 'yarn install --frozen-lockfile' }
  use { 'neoclide/coc-html', run = 'yarn install --frozen-lockfile' }
  use { 'neoclide/coc-prettier', run = 'yarn install --frozen-lockfile' }
  use { 'neoclide/coc-vetur', run = 'yarn install --frozen-lockfile' }
  use { 'neoclide/coc-eslint', run = 'yarn install --frozen-lockfile' }
  use { 'neoclide/coc-snippets', run = 'yarn install --frozen-lockfile' }
  use 'posva/vim-vue'
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
  use 'rafcamlet/nvim-luapad'
end


local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins
