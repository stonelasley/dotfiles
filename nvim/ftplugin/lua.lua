require('kartograaf').map({
  n = {
    buffer = 0,
    options = { noremap = false },
    {
      prefix = '<leader><leader>',
      { 'rt', '<Plug>PlenaryTestFile'},
      { 'so', ':luafile %<CR>', { silent = true }},
    }

  }
})
