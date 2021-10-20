require('kartograaf').map({
  n = {
    buffer = 0,
    options = { noremap = false },
    { '<F12>', '<cmd>lua vim.lsp.buf.formatting()<CR>' },
    {
      prefix = '<leader><leader>',
      { 'rt', '<Plug>PlenaryTestFile'},
      { 'so', ':luafile %<CR>', { silent = true }},
    }

  }
})

vim.api.nvim_exec(
  [[
  augroup Lua
    autocmd!
    autocmd BufWritePre *.lua :lua vim.lsp.buf.formatting() 
  augroup end
  ]],
  false
)
