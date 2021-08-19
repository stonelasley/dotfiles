-- TODO - must be a better way
require'compe'.setup { enabled = false}
vim.api.nvim_exec([[call deoplete#enable()]], true)
vim.api.nvim_exec([[call deoplete#custom#option('sources', { '_': ['buffer', 'ultisnips', 'file', 'dictionary'], 'cs': ['buffer', 'ultisnips', 'file', 'tag', 'omnisharp'] }) ]], true)
