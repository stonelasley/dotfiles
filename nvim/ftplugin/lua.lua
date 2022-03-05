require('kartograaf').map({
  n = {
    buffer = 0,
    options = { noremap = false },
    -- { '<F12>', '<cmd>lua vim.lsp.buf.formatting()<CR>' },
    {
      prefix = '<leader><leader>',
      { 'rt', '<Plug>PlenaryTestFile' },
      { 'so', ':luafile %<CR>', { silent = true } },
    },
  },
})
