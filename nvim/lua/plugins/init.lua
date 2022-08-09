vim.cmd [[packadd packer.nvim]]

local plugins = {
  { "lewis6991/impatient.nvim" },
  {
    "wbthomason/packer.nvim",
    event = "VimEnter",
  },
  { "nathom/filetype.nvim" },
  {
    "max397574/better-escape.nvim",
    event = "InsertCharPre",
    config = [[require('plugins.config.better-escape')]],
  },
  {
    "tpope/vim-surround",
    event = "BufRead",
  },
  { "tpope/vim-eunuch" },
  {
    "numToStr/Comment.nvim",
    config = [[require('plugins.config.comment')]],
  },
  {
    "andrewradev/splitjoin.vim",
    event = "BufRead",
  },
  { "svermeulen/vimpeccable" },
  {
    "windwp/nvim-autopairs",
    config = [[require('plugins.config.autopairs')]],
    after = "nvim-treesitter",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = [[require('plugins.config.indentguides')]],
    event = "BufRead",
  },
  {
    "stonelasley/flare.nvim",
    -- "~/Projects/st1/flare.nvim",
    config = [[require('plugins.config.flare')]],
  },
  { "wincent/loupe" },
  {
    "kyazdani42/nvim-tree.lua",
    after = "nvim-web-devicons",
    requires = { { "kyazdani42/nvim-web-devicons" } },
    config = [[require('plugins.config.nvim-tree')]],
  },
  { "nvim-telescope/telescope-fzy-native.nvim" },
  {
    "nvim-telescope/telescope-frecency.nvim",
    requires = { { "tami5/sql.nvim" } },
  },
  {
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    config = [[require('plugins.config.telescope')]],
    cmd = "Telescope",
  },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-path" },
  { "saadparwaiz1/cmp_luasnip" },
  {
    "hrsh7th/nvim-cmp",
    config = [[require('plugins.config.cmp')]],
  },
  { "github/copilot.vim" },
  {
    "phaazon/hop.nvim",
    as = "hop",
    config = [[require('plugins.config.hop')]],
  },
  { "christoomey/vim-tmux-navigator" },
  { "dhruvasagar/vim-zoom" },
  { "tpope/vim-fugitive" },
  {
    "prettier/vim-prettier",
    run = "yarn install",
    ft = {
      "css",
      "html",
      "javascript",
      "scss",
      "typescript",
      "vue",
    },
  },
  {
    "dense-analysis/ale",
    config = [[require('plugins.config.ale')]],
    ft = "cs",
  },
  {
    "L3MON4D3/LuaSnip",
    config = [[require('plugins.config.luasnip')]],
  },
  {
    "mfussenegger/nvim-dap",
    ft = { "cs", "rs" },
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = [[require('plugins.config.lsp_lines')]],
  },
  {
    "neovim/nvim-lspconfig",
    config = [[require('plugins.config.lsp').setup()]],
    requires = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "jose-elias-alvarez/null-ls.nvim",
      "folke/lua-dev.nvim",
      "b0o/schemastore.nvim",
    },
  },
  { "~/Projects/st1/dotnet.nvim" },
  {
    "glepnir/lspsaga.nvim",
    config = [[require('plugins.config.lspsaga')]],
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufRead", "BufNewFile" },
    run = ":TSUpdate",
    config = [[require('plugins.config.treesitter')]],
  },
  {
    "nvim-treesitter/playground",
    requires = { { "nvim-treesitter/nvim-treesitter" } },
    config = [[require('plugins.config.treesitterplayground')]],
    cmd = "TSPlaygroundToggle",
  },
  {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = [[require('plugins.config.trouble')]],
  },
  -- {
  --   "omnisharp/omnisharp-vim",
  --   config = [[require('plugins.config.omnisharp')]],
  --   ft = { "cs" },
  --   disabled = true,
  -- },

  { "euclidianace/betterlua.vim", ft = { "lua" } },
  {
    "rafcamlet/nvim-luapad",
    config = [[require('plugins.config.luapad')]],
    ft = { "lua" },
  },
  --use "tjdevries/nlua.nvim"

  { "posva/vim-vue", ft = { "typescript", "vue" } },
  {
    "simrat39/rust-tools.nvim",
    requires = { "nvim-lua/plenary.nvim", "rust-lang/rust.vim" },
    module = "rust-tools",
  },
  {
    "leafgarland/typescript-vim",
    config = [[require('plugins.config.typescript')]],
  },
  {
    "hoob3rt/lualine.nvim",
    requires = { { "kyazdani42/nvim-web-devicons" } },
    config = [[require('plugins.config.lualine')]],
  },
  {
    "onsails/lspkind-nvim",
    config = [[require('plugins.config.lspkind')]],
  },
  {
    "rmehri01/onenord.nvim",
    config = [[require('plugins.config.theme')]],
  },
  {
    "nvim-orgmode/orgmode",
    config = [[require('plugins.config.orgmode')]],
  },
  { "RishabhRD/popfix" },
  {
    "RishabhRD/nvim-cheat.sh",
    requires = { { "RishabhRD/popfix" } },
    event = { "BufRead", "BufNewFile" },
  },
  {
    "folke/which-key.nvim",
    config = [[require('plugins.config.whichkey')]],
  },
}

return require("packer").startup(function(use)
  use(plugins)
end)
