require('kartograaf').map(
{
  n = {
    buffer = 0,
    options = { noremap = false },
    {
      prefix = '<leader>',
      { 't', '<Plug>PlenaryTestFile'},
      { 'f', ':luafile %<CR>', { silent = true }},
    }

  }
}
)
--utils.buf_map(0, 'n', '<leader>t', '<Plug>PlenaryTestFile', { noremap = false })
--utils.buf_map(0, 'n', '<leader>f', ':luafile %<CR>', { noremap = false, silent = false })
