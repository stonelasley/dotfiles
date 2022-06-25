local M = {}

M.treesitter = {
  ensure_installed = {
    "bash",
    "c",
    "c_sharp",
    "css",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "norg",
    "org",
    "rust",
    "toml",
    "typescript",
    "vim",
  }
}

M.cmp = {
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" },
    { name = "org" },
  },
}
return M
