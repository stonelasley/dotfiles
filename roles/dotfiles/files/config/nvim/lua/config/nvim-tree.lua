local utils = require('utils')

utils.map('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true })
utils.map('n', '<leader>r>', ':NvimTreeRefresh<CR>', { noremap = true })
utils.map('n', '<leader>n>', ':NvimTreeFindFile<CR>', { noremap = true })
