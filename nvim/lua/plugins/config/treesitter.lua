-- vim.wo.foldmethod = 'expr'
-- vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
-- vim.cmd('set foldmethod=expr')
-- vim.cmd('set foldexpr=nvim_treesitter#foldexpr()')
require('nvim-treesitter.configs').setup({
  autopairs = { enable = true },
})
