return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        -- "omnisharp",
        "csharpier",
        "prettierd",
        "rust-analyzer",
        "lua-language-server",
        "codelldb",
      },
    },
  },
}
