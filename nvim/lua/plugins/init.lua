local plugins = {
  -- Util
  { "lewis6991/impatient.nvim" },
  -- Search / Find
  {
    "kyazdani42/nvim-tree.lua",
    -- after = "nvim-web-devicons",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require "plugins.config.nvim-tree"
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
      {
        "nvim-telescope/telescope-frecency.nvim",
        dependencies = { "tami5/sql.nvim" },
      },
    },
    config = function()
      require "plugins.config.telescope"
    end,
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
      require "plugins.config.cmp"
    end,
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      {
        "hrsh7th/cmp-copilot",
        event = "InsertEnter",
        config = function()
          require("plugins.config.copilot").setup()
        end,
      },
      "saadparwaiz1/cmp_luasnip",
      {
        "onsails/lspkind-nvim",
        config = function()
          require "plugins.config.lspkind"
        end,
      },
      {
        "L3MON4D3/LuaSnip",
        config = function()
          require "plugins.config.luasnip"
        end,
      },
    },
  },
  { "github/copilot.vim", event = "InsertEnter" },
  -- Movement
  {
    "phaazon/hop.nvim",
    name = "hop",
    config = function()
      require "plugins.config.hop"
    end,
  },
  { "christoomey/vim-tmux-navigator" },
  { "dhruvasagar/vim-zoom" },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require "plugins.config.todo"
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.config.lsp").setup()
    end,
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "jose-elias-alvarez/null-ls.nvim",
      "folke/neodev.nvim",
      "b0o/schemastore.nvim",
      "hoffs/omnisharp-extended-lsp.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "hrsh7th/nvim-cmp",
      "jayp0521/mason-null-ls.nvim",
      {
        "simrat39/inlay-hints.nvim",
        config = function()
          require "plugins.config.inlay-hints"
        end,
      },
      {
        "maan2003/lsp_lines.nvim",
        config = function()
          require "plugins.config.lsp_lines"
        end,
      },
      {
        "glepnir/lspsaga.nvim",
        config = function()
          require "plugins.config.lspsaga"
        end,
      },
      {
        "theHamsta/nvim-semantic-tokens",
        config = function()
          require("plugins.config.semantic-tokens").setup()
        end,
      },
      {
        "simrat39/rust-tools.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "rust-lang/rust.vim",
          {
            "saecki/crates.nvim",
            event = { "BufRead Cargo.toml" },
            dependencies = { { "nvim-lua/plenary.nvim" } },
            config = {
              null_ls = {
                enabled = true,
                name = "crates.nvim",
              },
            },
          },
        },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufRead", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      require "plugins.config.treesitter"
    end,
  },
  {
    "nvim-treesitter/playground",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require "plugins.config.treesitterplayground"
    end,
    cmd = "TSPlaygroundToggle",
  },
  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require "plugins.config.trouble"
    end,
  },
  -- Debugging
  {
    "mfussenegger/nvim-dap",
    opt = true,
    name = "dap",
    dependencies = {
      { "theHamsta/nvim-dap-virtual-text", name = "nvim-dap-virtual-text" },
      { "rcarriga/nvim-dap-ui", name = "dapui" },
      { "mfussenegger/nvim-dap-python", name = "dap-python" },
      "nvim-telescope/telescope-dap.nvim",
      { "leoluz/nvim-dap-go", name = "dap-go" },
      { "jbyuki/one-small-step-for-vimkind", name = "osv" },
      { "mxsdev/nvim-dap-vscode-js", name = "dap-vscode-js" },
      {
        "microsoft/vscode-js-debug",
        opt = true,
        build = "npm install --legacy-peer-deps && npm run compile",
      },
    },
    config = function()
      require("plugins.config.dap").setup()
    end,
  },

  -- Vue
  { "posva/vim-vue", ft = { "typescript", "vue" } },
  -- Rust
  -- Typescript
  {
    "leafgarland/typescript-vim",
    config = function()
      require "plugins.config.typescript"
    end,
  },

  -- Theme
  {
    "rmehri01/onenord.nvim",
    config = function()
      require "plugins.config.theme"
    end,
  },
  {
    "hoob3rt/lualine.nvim",
    dependencies = { { "kyazdani42/nvim-web-devicons" } },
    config = function()
      require "plugins.config.lualine"
    end,
  },

  -- Misc
  {
    "tpope/vim-fugitive",
    cmd = "Git",
  },
  {
    "stonelasley/flare.nvim",
    config = function()
      require "plugins.config.flare"
    end,
  },
  {
    "nvim-orgmode/orgmode",
    config = function()
      require "plugins.config.orgmode"
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "RishabhRD/nvim-cheat.sh",
    dependencies = { { "RishabhRD/popfix" } },
    event = { "BufRead", "BufNewFile" },
  },
  {
    "folke/which-key.nvim",
    config = function()
      require "plugins.config.whichkey"
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "v2.*",
    config = true,
  },
  { "nathom/filetype.nvim" },
  {
    "max397574/better-escape.nvim",
    event = "InsertCharPre",
    config = function()
      require "plugins.config.better-escape"
    end,
  },
  {
    "tpope/vim-surround",
    event = "BufRead",
  },
  { "tpope/vim-eunuch" },
  {
    "numToStr/Comment.nvim",
    config = function()
      require "plugins.config.comment"
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  {
    "andrewradev/splitjoin.vim",
    event = "BufRead",
  },
  { "svermeulen/vimpeccable" },
  {
    "windwp/nvim-autopairs",
    config = function()
      require "plugins.config.autopairs"
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require "plugins.config.indentguides"
    end,
  },
  {
    "jackMort/ChatGPT.nvim",
    config = function()
      require("plugins.config.chatgpt").setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
}

vim.g.mapleader = " " -- make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup(plugins)
