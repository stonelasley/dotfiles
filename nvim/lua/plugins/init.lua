local plugins = {
  -- Util
  { "lewis6991/impatient.nvim" },
  {
    "wbthomason/packer.nvim",
    event = "VimEnter",
  },
  -- Search / Find
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
  },

  -- Completion
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-copilot" },
  { "saadparwaiz1/cmp_luasnip" },
  {
    "hrsh7th/nvim-cmp",
    config = [[require('plugins.config.cmp')]],
  },
  { "github/copilot.vim" },
  -- Movement
  {
    "phaazon/hop.nvim",
    as = "hop",
    config = [[require('plugins.config.hop')]],
  },
  { "christoomey/vim-tmux-navigator" },
  { "dhruvasagar/vim-zoom" },
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
    "L3MON4D3/LuaSnip",
    config = [[require('plugins.config.luasnip')]],
  },
  {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = [[require('plugins.config.todo')]],
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = [[require('plugins.config.lsp').setup()]],
    requires = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "jose-elias-alvarez/null-ls.nvim",
      "folke/neodev.nvim",
      "b0o/schemastore.nvim",
      "hoffs/omnisharp-extended-lsp.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "jayp0521/mason-null-ls.nvim",
      {
        "simrat39/inlay-hints.nvim",
        config = [[require('plugins.config.inlay-hints')]],
      },
      {
        "theHamsta/nvim-semantic-tokens",
        config = [[require('plugins.config.semantic-tokens').setup()]],
      },
    },
  },
  {
    "maan2003/lsp_lines.nvim",
    config = [[require('plugins.config.lsp_lines')]],
  },
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
  {
    "onsails/lspkind-nvim",
    config = [[require('plugins.config.lspkind')]],
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    ft = { "cs", "rs" },
  },


  -- Vue
  { "posva/vim-vue", ft = { "typescript", "vue" } },
  -- Rust
  {
    "simrat39/rust-tools.nvim",
    requires = { "nvim-lua/plenary.nvim", "rust-lang/rust.vim" },
    module = "rust-tools",
  },
  -- Typescript
  {
    "leafgarland/typescript-vim",
    config = [[require('plugins.config.typescript')]],
  },

  -- Theme
  {
    "rmehri01/onenord.nvim",
    config = [[require('plugins.config.theme')]],
  },
  {
    "hoob3rt/lualine.nvim",
    requires = { { "kyazdani42/nvim-web-devicons" } },
    config = [[require('plugins.config.lualine')]],
  },

  -- Misc
  { "tpope/vim-fugitive" },
  {
    "stonelasley/flare.nvim",
    config = [[require('plugins.config.flare')]],
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
  {
    "akinsho/toggleterm.nvim",
    tag = "v2.*",
    config = [[require('plugins.config.toggleterm')]],
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
}

local packer = require "packer"

packer.init {
  auto_clean = true,
  compile_on_sync = true,
  git = { clone_timeout = 6000 },
  display = {
    working_sym = "ﲊ",
    error_sym = "✗ ",
    done_sym = " ",
    removed_sym = " ",
    moved_sym = "",
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
  },
  log = { level = "warn" },
}
packer.reset()
-- packer.use(plugins)
packer.startup(function(use)
  use(plugins)
end)
