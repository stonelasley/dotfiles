local utils = require('utils')

utils.map('i', 'jk', '<Esc>')
utils.map('n', '<Space>', '<Nop>')

-- Toggle fold under cursor
utils.map('n', '<C-=>', 'zm')
utils.map('n', '<C-->', 'zr')

-- Window Movement --
utils.map('n', '<C-h>', '<C-w>h')
utils.map('n', '<C-j>', '<C-w>j')
utils.map('n', '<C-k>', '<C-w>k')
utils.map('n', '<C-l>', '<C-w>l')

utils.map('n', '<leader>ls', ':ls<CR>:b<space>')

-- Window Size --
utils.map('n', '<M-j>', ':resize-2')
utils.map('n', '<M-k>', ':resize+2')
utils.map('n', '<M-h>', ':vertical resize-2')
utils.map('n', '<M-l>', ':vertical resize+2')

utils.map('n', '<CR>', ':noh<CR><CR>')

utils.map('c', 'w!!', 'w !sudo tee %')

utils.map('n', '<leader>ls', ':ls<CR>:b<space>')
utils.map('n', '<CR>', ':noh<CR><CR>')
-- Replace current word
--utils.map('n', '<Leader>rr', ":%s/\\<C-r><C-w>/")
