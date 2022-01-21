require('cmp').setup.buffer { enabled = false }
vim.api.nvim_exec([[ call ncm2#enable_for_buffer() ]], false)
vim.cmd([[
  let colorColumn=100
  let b:ale_linters = { 'cs': ['OmniSharp'] } 
]])
