-- vim.wo.foldmethod = 'expr'
-- vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
require("nvim-treesitter.configs").setup {
  ensure_installed = { "typescript", "rust", "javascript", "c_sharp", "html", "json", "yaml", "c", "lua" },
  autopairs = { enable = true },
  auto_install = true,
  highlight = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
  },
}
