vim.g.mapleader = " "
require('kartograaf').map({
  i = {
    { 'jk', '<Esc>' },
    -- Break undo points
    { ',', ',<c-g>u' },
    { '.', '.<c-g>u' },
    { ';', ';<c-g>u' },
    --{ ')', ')<c-g>u' },
    --{ ']', ']<c-g>u' },
    --{ '}', '}<c-g>u' },
  },
  n = {
    { '<Space>', '<Nop>' },
    { '<tab>', 'za' },
    --{ '<CR>', ':noh<CR><CR>' },
    { 'Y', 'y$' },
    -- Toggle fold under cursor
    {
      prefix = '<leader>',
      { 'ls', ':ls<CR>:b<space>' },
      { 'w', [[<cmd>lua require'hop'.hint_words()<cr>]] },
      { 'l', [[<cmd>lua require'hop'.hint_lines()<cr>]] },
      { 'c', [[<cmd>lua require'hop'.hint_char1()<cr>]] },
    },
    {
      mod = 'C',
      -- Window Movement --
      { 'h', '<C-w>h' },
      { 'j', '<C-w>j' },
      { 'k', '<C-w>k' },
      { 'l', '<C-w>l' },
      -- Toggle fold under cursor
      { '=', 'zm' },
      { '-', 'zr' },
    },
    {
      mod = 'M',
      -- Window Size --
      { 'h', ':vertical resize-2' },
      { 'j', ':resize-2' },
      { 'k', ':resize+2' },
      { 'l', ':vertical resize+2' },
    }
  },
  c = {
    { 'w!!', 'w !sudo tee %'}
  }
})
