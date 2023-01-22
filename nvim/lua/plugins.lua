local plugins = {
  -- Util
  { "lewis6991/impatient.nvim" },
  -- Search / Find
  {
    "kyazdani42/nvim-tree.lua",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require "config.plugins.nvim-tree"
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
      require "config.plugins.telescope"
    end,
  },
  -- Completion
  {
    "github/copilot.vim",
    config = function()
      require "config.plugins.copilot"
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
      require "config.plugins.cmp"
    end,
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      {
        "onsails/lspkind.nvim",
        config = function()
          require "config.plugins.lspkind"
        end,
      },
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        config = function()
          require "config.plugins.luasnip"
        end,
      },
      "rafamadriz/friendly-snippets",
    },
  },
  -- Movement
  {
    "phaazon/hop.nvim",
    event = { "BufRead", "BufNewFile" },
    name = "hop",
    config = {
      keys = "etovxqpdygfblzhckisuran",
    },
  },
  { "christoomey/vim-tmux-navigator" },
  { "dhruvasagar/vim-zoom", event = "BufRead" },
  { "dhruvasagar/vim-zoom" },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require "config.plugins.todo"
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("config.lsp").setup()
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
        config = true,
      },
      {
        "maan2003/lsp_lines.nvim",
        config = function()
          require "config.plugins.lsp_lines"
        end,
      },
      {
        "glepnir/lspsaga.nvim",
        config = true
      },
      {
        "theHamsta/nvim-semantic-tokens",
        config = function()
          require("config.plugins.semantic-tokens").setup()
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
      require "config.plugins.treesitter"
    end,
  },
  {
    "nvim-treesitter/playground",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require "config.plugins.treesitterplayground"
    end,
    cmd = "TSPlaygroundToggle",
  },
  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require "config.plugins.trouble"
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
      require("config.dap").setup()
    end,
  },

  -- Vue
  { "posva/vim-vue", ft = { "typescript", "vue" } },
  -- Typescript
  {
    "leafgarland/typescript-vim",
    config = function()
      require "config.plugins.typescript"
    end,
  },
  -- Theme
  {
    "rmehri01/onenord.nvim",
    config = function()
      require("config.plugins.theme").setup()
    end,
  },
  {
    "hoob3rt/lualine.nvim",
    dependencies = { { "kyazdani42/nvim-web-devicons" } },
    config = function()
      require "config.plugins.lualine"
    end,
  },

  -- Misc
  {
    "lewis6991/gitsigns.nvim",
    cmd = "Gitsigns",
    config = true,
  },
  {
    "stonelasley/flare.nvim",
    event = { "BufRead", "BufNewFile" },
    config = true,
  },
  {
    "nvim-orgmode/orgmode",
    config = function()
      require "config.plugins.orgmode"
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
      require "config.plugins.whichkey"
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "v2.*",
    -- config = true,
    event = "BufRead",
  },
  { "nathom/filetype.nvim" },
  {
    "max397574/better-escape.nvim",
    event = "InsertCharPre",
    config = function()
      require "config.plugins.better-escape"
    end,
  },
  {
    "tpope/vim-surround",
    event = { "BufRead", "BufNewFile" },
  },
  { "tpope/vim-eunuch" },
  {
    "numToStr/Comment.nvim",
    config = true,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  {
    "andrewradev/splitjoin.vim",
    event = { "BufRead", "BufNewFile" },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require "config.plugins.indentguides"
    end,
  },
  { "svermeulen/vimpeccable" },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require "config.plugins.autopairs"
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    lazy = true,
  },
  {
    "dense-analysis/neural",
    config = {
      open_ai = {
        api_key = os.getenv "OPENAI_API_KEY",
      },
    },
  },
  {
    "jackMort/ChatGPT.nvim",
    config = true,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
}

vim.g.mapleader = " " -- make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup(plugins)
