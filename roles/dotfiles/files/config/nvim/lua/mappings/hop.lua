local map = require('utils').map

map('n', '<leader>w', "<cmd>lua require'hop'.hint_words()<cr>", { })
map('n', '<leader>l', "<cmd>lua require'hop'.hint_lines()<cr>", { })
map('n', '<leader>c', "<cmd>lua require'hop'.hint_char1()<cr>", { })
