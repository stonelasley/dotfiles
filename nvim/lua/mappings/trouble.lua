local map = require('utils').map
local opts = { silent = true }

vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>", opt)
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", opt)
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>", opt)
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>", opt)
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", opt)
vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", opt)
