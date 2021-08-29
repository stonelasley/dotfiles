require('kartograaf').map({
  n = {
    buffer = 0,
    options = { noremap = false },
    {
      prefix = '<leader>',
      { 't', '<Plug>PlenaryTestFile'},
      { 'f', ':luafile %<CR>', { silent = true }},
    }

  }
})
