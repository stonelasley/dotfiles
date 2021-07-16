local utils = require('utils')

utils.map('n', '<C-p>', '<cmd>Telescope find_files<cr>', { noremap = true })
utils.map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { noremap = true  })
utils.map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { noremap = true  })
utils.map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { noremap = true  })

