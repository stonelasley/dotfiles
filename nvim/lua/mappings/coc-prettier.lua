local map = require('utils').map

map('n', '<leader><leader>p', "<cmd>:CocCommand prettier.formatFile<cr>", { })
