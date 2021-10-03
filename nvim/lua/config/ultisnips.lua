vim.g.UltiSnipsSnippetDirectories = {'UltiSnips'}
--vim.g.UltiSnipsExpandTrigger="<CR>"
vim.g.UltiSnipsExpandTrigger = "<nop>"
vim.g.UltiSnipsJumpForwardTrigger="<Tab>"
vim.g.UltiSnipsJumpBackwardTrigger="<S-Tab>"

--If you want :UltiSnipsEdit to split your window.
vim.g.UltiSnipsEditSplit="vertical"
vim.cmd([[inoremap <expr> <CR> (pumvisible() && UltiSnips#CanExpandSnippet()) ? "<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>" : "\<CR>"]])

