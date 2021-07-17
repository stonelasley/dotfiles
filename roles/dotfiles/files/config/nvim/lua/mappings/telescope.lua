local map = require('utils').map

map('n', '<C-p>', '<cmd>Telescope find_files<cr>', { noremap = true })
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { noremap = true  })
-- map('n', '<leader><leader>fc', '<cmd>Telescope git_commits<cr>', { noremap = true  })
map('n', '<leader>fc', '<cmd>Telescope git_bcommits<cr>', { noremap = true  })
map('n', '<leader><leader>fb', '<cmd>Telescope git_branches<cr>', { noremap = true  })
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { noremap = true  })
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { noremap = true  })
