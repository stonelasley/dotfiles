local map = require('utils').map

map('i', 'jk', '<Esc>')
map('n', '<Space>', '<Nop>')

-- Toggle fold under cursor
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

map('n', '<leader>ls', ':ls<CR>:b<space>')
map('n', '<CR>', ':noh<CR><CR>')

-- Line selection behavior, cheers Primeagen!
map('n', 'Y', 'y$')
