require('kartograaf').map({
  n = {
    options = { silent = true},
    {
      prefix = '<leader>',
      { 't', '<cmd>Trouble<CR>'},
      { 'tw', '<cmd>Trouble lsp_workspace_diagnostics<CR>'},
      { 'td', '<cmd>Trouble lsp_document_diagnostics<CR>'},
      { 'tl', '<cmd>Trouble loclist<CR>'},
      { 'tq', '<cmd>Trouble quickfix<CR>'},
    }
  }
})
