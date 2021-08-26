vim.api.nvim_exec([[call deoplete#enable()]], true)
vim.api.nvim_exec([[call deoplete#custom#option('sources', { '_': ['buffer', 'ultisnips', 'file', 'dictionary'], 'cs': ['buffer', 'ultisnips', 'file', 'tag', 'omnisharp'] }) ]], true)
vim.api.nvim_exec([[autocmd FileType TelescopePrompt call deoplete#custom#buffer_option('auto_complete', v:false) ]], true)
