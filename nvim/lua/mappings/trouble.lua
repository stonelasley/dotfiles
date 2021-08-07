local map = require('utils').map
local opt = { silent = true }

map("n", "<leader>xx", "<cmd>Trouble<cr>", opt)
map("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", opt)
map("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>", opt)
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", opt)
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", opt)
map("n", "gR", "<cmd>Trouble lsp_references<cr>", opt)
