local utils = require('utils')

require'hop'.setup()
utils.map('n', '<leader>w', "<cmd>lua require'hop'.hint_words()<cr>", { })
utils.map('n', '<leader>l', "<cmd>lua require'hop'.hint_lines()<cr>", { })
utils.map('n', '<leader>c', "<cmd>lua require'hop'.hint_char1()<cr>", { })
