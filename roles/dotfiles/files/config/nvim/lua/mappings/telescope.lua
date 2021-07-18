local map = require('utils').map

local noremap = { noremap = true }
map('n', '<C-p>', '<cmd>Telescope find_files<cr>', noremap)
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', noremap)
-- map('n', '<leader>st', "require('config.telescope').search_dotfiles()<cr>", noremap)
-- map('n', '<leader><leader>fc', '<cmd>Telescope git_commits<cr>', noremap)
map('n', '<leader>fc', '<cmd>Telescope git_bcommits<cr>', noremap)
map('n', '<leader><leader>fb', '<cmd>Telescope git_branches<cr>', noremap)
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', noremap)
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', noremap)
