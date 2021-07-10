local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


-- Toggle fold under cursor
map('i', 'jk', '<Esc>')
map('n', '<Space>', '<Nop>')
map('n', '<C-=>', 'zm')
map('n', '<C-->', 'zr')

-- Window Movement --
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

map('n', '<leader>ls', ':ls<CR>:b<space>')

-- Window Size --
map('n', '<M-j>', ':resize-2')
map('n', '<M-k>', ':resize+2')
map('n', '<M-h>', ':vertical resize-2')
map('n', '<M-l>', ':vertical resize+2')

map('n', '<CR>', ':noh<CR><CR>')

map('c', 'w!!', 'w !sudo tee %')

-- Replace current word
--map('n', '<Leader>rr', ":%s/\\<C-r><C-w>/")
