local map = require('utils').map
local cmd = vim.cmd

local noremap = { noremap = true }
map('n', '<C-p>', '<cmd>Telescope find_files<cr>', noremap)
map('n', '<C-f>', '<cmd>Telescope live_grep<cr>', noremap)
map('n', '<leader>s', '<cmd>Telescope grep_string<cr>', noremap)
-- todo - how do I do this in lua? see telescope.vim
-- map('n', '<leader>st', "require('config.telescope').search_dotfiles()<cr>", noremap)
map('n', '<leader><leader>gc', '<cmd>Telescope git_bcommits<cr>', noremap)
map('n', '<leader><leader>gb', '<cmd>Telescope git_branches<cr>', noremap)
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', noremap)
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', noremap)
