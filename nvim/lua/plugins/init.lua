vim.cmd([[packadd packer.nvim]])

return require('packer').startup(function(use)
  use('lewis6991/impatient.nvim')
  use('nathom/filetype.nvim')
  use({
    'wbthomason/packer.nvim',
    event = 'VimEnter',
  })
  use({
    'max397574/better-escape.nvim',
    event = 'InsertCharPre',
    config = [[require('plugins.config.better-escape')]],
  })

  -- Convenience Utilities
  use({
    'tpope/vim-sleuth',
    event = { 'BufRead', 'BufNewFile' },
  })
  use({
    'tpope/vim-surround',
    event = 'BufRead',
  })
  use('tpope/vim-eunuch')
  use({
    'numToStr/Comment.nvim',
    config = [[require('plugins.config.comment')]],
  })
  use('tpope/vim-projectionist')
  use({
    'andrewradev/splitjoin.vim',
    event = 'BufRead',
  })
  use('svermeulen/vimpeccable')
  use({
    'windwp/nvim-autopairs',
    config = [[require('plugins.config.autopairs')]],
    after = 'nvim-treesitter',
  })
  use({
    'lukas-reineke/indent-blankline.nvim',
    config = [[require('plugins.config.indentguides')]],
    event = 'BufRead',
  })
  use({
    'DanilaMihailov/beacon.nvim',
    config = [[require('plugins.config.beacon')]],
  })

  -- Searching & Finding
  use('wincent/loupe')
  use({
    'kyazdani42/nvim-tree.lua',
    after = 'nvim-web-devicons',
    requires = { { 'kyazdani42/nvim-web-devicons' } },
    config = [[require('plugins.config.nvim-tree')]],
  })
  use('nvim-telescope/telescope-fzy-native.nvim')
  use({
    'nvim-telescope/telescope-frecency.nvim',
    requires = { { 'tami5/sql.nvim' } },
  })
  use({
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
    config = [[require('plugins.config.telescope')]],
    cmd = 'Telescope',
  })

  -- Completion
  use({ 'hrsh7th/cmp-buffer' })
  use({ 'hrsh7th/cmp-nvim-lsp' })
  use({ 'hrsh7th/cmp-path' })
  use({ 'saadparwaiz1/cmp_luasnip' })
  use({
    'L3MON4D3/LuaSnip',
    config = [[require('plugins.config.luasnip')]],
  })
  -- use({ 'quangnguyen30192/cmp-nvim-ultisnips' })
  use({
    'hrsh7th/nvim-cmp',
    config = [[require('plugins.config.cmp')]],
  })
  use({ 'github/copilot.vim' })

  -- TODO temporary until I decide how to address c# completion
  -- use({
  --   'ncm2/ncm2',
  --   requires = { { 'roxma/nvim-yarp' }, { 'ncm2/ncm2-ultisnips' } },
  --   config = [[require('plugins.config.ncm2')]],
  --   ft = 'cs',
  -- })
  use({
    'junegunn/fzf.vim',
    ft = 'cs',
  })

  -- Movement
  use({
    'phaazon/hop.nvim',
    as = 'hop',
    config = [[require('plugins.config.hop')]],
  })
  use('christoomey/vim-tmux-navigator')
  use('dhruvasagar/vim-zoom')

  -- Git
  use('tpope/vim-fugitive')

  -- Linting
  use({
    'jose-elias-alvarez/null-ls.nvim',
    config = [[require('plugins.config.null-ls')]],
  })
  use({
    'prettier/vim-prettier',
    run = 'yarn install',
    ft = {
      'css',
      'html',
      'javascript',
      'scss',
      'typescript',
      'vue',
    },
  })
  use({
    'dense-analysis/ale',
    config = [[require('plugins.config.ale')]],
    ft = 'cs',
  })

  -- Snippets
  -- use({
  --   'sirver/ultisnips',
  --   config = [[require('plugins.config.ultisnips')]],
  --   ft = 'cs',
  -- })
  -- use({ 'honza/vim-snippets' })
  -- use({ 'hrsh7th/vim-vsnip' })
  -- use({ 'softchris/ts-snippets' })

  -- Debug
  use({
    'mfussenegger/nvim-dap',
    ft = { 'cs', 'rs' },
  })

  -- Languages
  use({
    'neovim/nvim-lspconfig',
    config = [[require('plugins.config.lsp')]],
  })
  use({
    'tami5/lspsaga.nvim',
    config = [[require('plugins.config.lspsaga')]],
  })
  use({
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufRead', 'BufNewFile' },
    run = ':TSUpdate',
    config = [[require('plugins.config.treesitter')]],
  })
  use({
    'nvim-treesitter/playground',
    requires = { { 'nvim-treesitter/nvim-treesitter' } },
    config = [[require('plugins.config.treesitterplayground')]],
    cmd = 'TSPlaygroundToggle',
  })
  -- use {
  --    "folke/trouble.nvim",
  --    requires = "kyazdani42/nvim-web-devicons",
  --    config = [[require('plugins.config.trouble')]]
  -- }

  -- C#
  use({
    'omnisharp/omnisharp-vim',
    config = [[require('plugins.config.omnisharp')]],
    ft = { 'cs' },
  })

  -- lua
  use({ 'euclidianace/betterlua.vim', ft = { 'lua' } })
  use({
    'rafcamlet/nvim-luapad',
    config = [[require('plugins.config.luapad')]],
    ft = { 'lua' },
  })
  -- use 'tjdevries/nlua.nvim'

  -- vue
  use({ 'posva/vim-vue', ft = { 'typescript', 'vue' } })

  -- rust
  use({
    'simrat39/rust-tools.nvim',
    config = [[require('plugins.config.rust-tools')]],
  })

  -- typescript
  use({
    'leafgarland/typescript-vim',
    config = [[require('plugins.config.typescript')]],
  })

  -- Themes
  use({
    'hoob3rt/lualine.nvim',
    requires = { { 'kyazdani42/nvim-web-devicons' } },
    config = [[require('plugins.config.lualine')]],
  })
  use({
    'onsails/lspkind-nvim',
    config = [[require('plugins.config.lspkind')]],
  })

  use({
    'rmehri01/onenord.nvim',
    config = [[require('plugins.config.neon')]],
  })

  -- Notes
  use({
    'vimwiki/vimwiki',
    config = [[require('plugins.config.vimwiki')]],
  })

  use({ 'RishabhRD/popfix' })
  use({
    'RishabhRD/nvim-cheat.sh',
    requires = { { 'RishabhRD/popfix' } },
    event = { 'BufRead', 'BufNewFile' },
  })

  -- Bindings
  use({
    'stonelasley/kartograaf.nvim',
    config = [[require('mappings')]],
  })

  -- use {
  --   'folke/which-key.nvim',
  --   config = [[require('plugins.config.whichkey')]]
  -- }
end)
