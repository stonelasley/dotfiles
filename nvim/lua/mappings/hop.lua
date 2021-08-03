local map = require('utils').map

map('n', '<leader>gw', "<cmd>lua require'hop'.hint_words()<cr>", { })
map('n', '<leader>gl', "<cmd>lua require'hop'.hint_lines()<cr>", { }) map('n', '<leader>gc',
"<cmd>lua require'hop'.hint_char1()<cr>", { })
