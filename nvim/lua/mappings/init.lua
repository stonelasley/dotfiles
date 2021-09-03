require('kartograaf').map({
  i = {
    { 'jk', '<Esc>' },
    -- Break undo points
    { ',', ',<c-g>u' },
    { '.', '.<c-g>u' },
    { ';', ';<c-g>u' },
    {
      mod = 'C',
      { '<Space>', 'compe#complete()', { expr = true, silent = true} },
      { '<e>', [[compe#close('<C-e>')]], { expr = true, silent = true} },
      { '<f>', [[compe#scroll({ 'delta': +4 })]], { expr = true, silent = true} },
      { '<d>', [[compe#scroll({ 'delta': -4 })]], { expr = true, silent = true} }
    }
  },
  n = {
    { '<Space>', '<Nop>' },
    -- Toggle fold under cursor
    { '<tab>', 'za' },
    -- Clear search highlight
    { '<CR>', ':noh<CR><CR>' },
    { 'Y', 'y$' },
    { '<F12>', '<plug>(Prettier)<CR>', { silent = true, noremap = false} },
    {
      prefix = '<leader>',
      { 'ls', ':ls<CR>:b<space>' },
      -- nvim-tree
      { 'r', ':NvimTreeRefresh<CR>' },
      { 'n', ':NvimTreeFindFile<CR>' },
      -- hop.nvim
      { 'w', [[<cmd>lua require'hop'.hint_words()<cr>]] },
      { 'c', [[<cmd>lua require'hop'.hint_char1()<cr>]] },
      -- trouble
      { 't', '<cmd>Trouble<CR>', { silent = true } },
      { 'tw', '<cmd>Trouble lsp_workspace_diagnostics<CR>', { silent = true } },
      { 'td', '<cmd>Trouble lsp_document_diagnostics<CR>', { silent = true } },
      { 'tl', '<cmd>Trouble loclist<CR>', { silent = true } },
      { 'tq', '<cmd>Trouble quickfix<CR>', { silent = true } }
    },
    {
      prefix = '<leader><leader>',
      { 'g', '<cmd>Telescope live_grep<CR>' },
      { 'w', '<cmd>Telescope grep_string<CR>' },
      { 'ls', '<cmd>Telescope grep_string<CR>' },
      { 'fh', '<cmd>Telescope help_tags<CR>' },
      { 'fb', '<cmd>Telescope buffers<CR>' },
      { 'gc', '<cmd>Telescope git_bcommits<CR>' },
      { 'gb', '<cmd>Telescope git_branches<CR>' },
    },
    {
      mod = 'C',
      { 'h', '<C-w>h' },
      { 'j', '<C-w>j' },
      { 'k', '<C-w>k' },
      { 'l', '<C-w>l' },
      { 'n', ':NvimTreeToggle<CR>' },
      { 'p', ':Telescope find_files<CR>' },
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

-- compe
vim.cmd([[inoremap <silent><expr> <CR>      compe#confirm(luaeval("require 'nvim-autopairs'.autopairs_cr()"))]])
-- telescope
vim.cmd([[nnoremap <leader>dot :lua require('st1.telescope').focus_find()<CR> ]])

vim.g.mapleader = " "
