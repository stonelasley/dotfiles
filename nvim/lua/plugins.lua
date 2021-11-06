vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
   use 'wbthomason/packer.nvim'
   use 'lewis6991/impatient.nvim'

   -- Convenience Utilities
   use 'tpope/vim-sleuth'
   use 'tpope/vim-surround'
   use 'tpope/vim-commentary'
   use 'tpope/vim-eunuch'
   use 'tpope/vim-projectionist'
   use 'andrewradev/splitjoin.vim'
   use 'svermeulen/vimpeccable'
   use {
      'windwp/nvim-autopairs' ,
      config = [[require('config.autopairs')]]
   }
   use {
      'lukas-reineke/indent-blankline.nvim',
      config = [[require('config.indentguides')]]
   }

   -- Searching & Finding
   use 'wincent/loupe'
   use {
      'kyazdani42/nvim-tree.lua',
      requires = { { 'kyazdani42/nvim-web-devicons' } },
      config = [[require('config.nvim-tree')]]
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
   use { 'hrsh7th/cmp-buffer' }
   use { 'hrsh7th/cmp-nvim-lsp' }
   use { 'hrsh7th/cmp-path' }
   use { 'github/copilot.vim' }
   use { 'tzachar/cmp-tabnine',
        run='./install.sh',
        requires = 'hrsh7th/nvim-cmp',
   }
   use { 'quangnguyen30192/cmp-nvim-ultisnips' }
   use {
      'hrsh7th/nvim-cmp',
      config = [[require('config.compe')]]
   }
   -- TODO temporary until I decide how to address c# completion
   use {
      'ncm2/ncm2',
      requires = { { 'roxma/nvim-yarp' }, { 'ncm2/ncm2-ultisnips'} },
      config = [[require('config.ncm2')]],
   }
   -- use {
   --   'shougo/deoplete.nvim',
   --   config = [[require('config.deoplete')]],
   --   run = ':UpdateRemotePlugins',
   --   ft = 'cs'
   -- }
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
      config = [[require('config.ale')]]
   }

   -- Snippets
   use {
      'sirver/ultisnips',
      config = [[require('config.ultisnips')]]
   }
   use { 'honza/vim-snippets' }
   use { 'hrsh7th/vim-vsnip' }
   use { 'softchris/ts-snippets' }

   -- Debug
   use { 'mfussenegger/nvim-dap' }

   -- Languages
   use {
      'neovim/nvim-lspconfig',
      config = [[require('config.lsp')]]
   }
   -- use {
   --    'glepnir/lspsaga.nvim',
   --    config = [[require('config.lspsaga')]]
   -- }
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
   -- use {
   --    "folke/trouble.nvim",
   --    requires = "kyazdani42/nvim-web-devicons",
   --    config = [[require('config.trouble')]]
   -- }

   -- C#
   use {
      'omnisharp/omnisharp-vim',
      config = [[require('config.omnisharp')]],
      ft = { 'cs'}
   }

   -- lua
   use { 'euclidianace/betterlua.vim', ft = { 'lua' } }
   use {
      'rafcamlet/nvim-luapad',
      config = [[require('config.luapad')]],
      ft = { 'lua'}
   }

   -- vue
   use { 'posva/vim-vue', ft = { 'typescript', 'vue' } }

   -- rust
   use {
      'simrat39/rust-tools.nvim',
      config = [[require('config.rust-tools')]]
   }

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

   use {
      'shaunsingh/nord.nvim',
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

   -- use {
   --   'folke/which-key.nvim',
   --   config = [[require('config.whichkey')]]
   -- }
end)
