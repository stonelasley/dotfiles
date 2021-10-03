require('compe').setup({ enabled = false}, 0)
vim.api.nvim_exec([[ call ncm2#enable_for_buffer() ]], false)
vim.cmd([[let b:ale_linters = { 'cs': ['OmniSharp'] } ]])
