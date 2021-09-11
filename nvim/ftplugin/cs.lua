require('compe').setup({ enabled = false}, 0)
vim.cmd([[let b:ale_linters  { 'cs': ['OmniSharp'] } ]])
vim.cmd([[set completeopt=noinsert,menuone,noselect]])
