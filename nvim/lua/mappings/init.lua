require('kartograaf').map({
  i = {
    { 'jk', '<Esc>' },
    -- Break undo points
    { ',', ',<c-g>u' },
    { '.', '.<c-g>u' },
    { ';', ';<c-g>u' },
    {
      mod = 'C',
      { 'e', [[<Cmd>lua require('cmp').complete()]], { expr = true, silent = true} }
    }
  },
  n = {
    --{ '<Space>', '<Nop>' },
    -- Clear search highlight
    { '<CR>', ':noh<CR><CR>' },
    { 'f', [[<cmd>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = false })<cr>]] },
    { 'F', [[<cmd>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = false })<cr>]] },
    { '<F12>', '<plug>(Prettier)<CR>', { silent = true, noremap = false} },
    {
      prefix = '<leader>',
      { 'y', '"+y' },
      { 'd', '"_d' },
      { 'Y', 'gg"+yG'},
      { 'ls', '<cmd>Telescope buffers<CR>' },
      { 't', '<cmd>Trouble<CR>', { silent = true } },
      { 'tw', '<cmd>Trouble lsp_workspace_diagnostics<CR>', { silent = true } },
      { 'td', '<cmd>Trouble lsp_document_diagnostics<CR>', { silent = true } },
      { 'tl', '<cmd>Trouble loclist<CR>', { silent = true } },
      { 'gs', '<cmd>Telescope grep_string<CR>' },
      { 'tq', '<cmd>Trouble quickfix<CR>', { silent = true } }
    },
    {
      prefix = '<leader><leader>',
      { 'fh', '<cmd>Telescope help_tags<CR>' },
      { 'ch', '<cmd>Telescope command_history<CR>' },
      { 'ft', '<cmd>Telescope tags<CR>' },
      { 'gc', '<cmd>Telescope git_bcommits<CR>' },
      { 'gb', '<cmd>Telescope git_branches<CR>' },
      { 'tvo', '<cmd>Telescope vim_options<CR>' },
      { 'trl', '<cmd>Telescope reloader<CR>' },
    },
    {
      mod = 'C',
      { 'h', '<cmd> :TmuxNavigateLeft<CR>' },
      { 'j', '<cmd> :TmuxNavigateDown<CR>' },
      { 'k', '<cmd> :TmuxNavigateUp<CR>' },
      { 'l', '<cmd> :TmuxNavigateRight<CR>' },
      { 'n', ':NvimTreeToggle<CR>' },
      { 'p', '<cmd>Telescope find_files<CR>' },
      { 'f', '<cmd>Telescope live_grep<CR>' },
      { '=', 'zm' },
      { '-', 'zr' },
    },
    {
      mod = 'M',
      -- Window Size --
      { 'h', '<cmd>:vertical resize+2<CR>' },
      { 'j', '<cmd>:resize-2<CR>' },
      { 'k', '<cmd>:resize+2<CR>' },
      { 'l', '<cmd>:vertical resize-2<CR>' },
    }
  },
  v = {
    {
      prefix = "<leader>",
      { 'p', '"_dP'},
      { 'y', '"+y' },
    }
  },
  x = {
    {
      prefix = "<leader>",
      { 'p', '"_dP'},
      { 'y', '"+y' },
    }
  },
  c = {
    { 'w!!', 'w !sudo tee %'}
  }
})

-- telescope
vim.cmd([[nnoremap <leader>dot :lua require('st1.telescope').focus_find()<CR> ]])
