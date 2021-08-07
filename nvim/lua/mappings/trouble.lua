local map = require('utils').map
local opt = { silent = true }

map("n", "<leader>t", "<cmd>Trouble<cr>", opt)
map("n", "<leader>tw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", opt)
map("n", "<leader>td", "<cmd>Trouble lsp_document_diagnostics<cr>", opt)
map("n", "<leader>tl", "<cmd>Trouble loclist<cr>", opt)
map("n", "<leader>tq", "<cmd>Trouble quickfix<cr>", opt)
