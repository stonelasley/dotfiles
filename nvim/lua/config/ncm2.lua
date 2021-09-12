vim.api.nvim_exec([[ call ncm2#enable_for_buffer() ]], false)
vim.cmd([[set completeopt=noinsert,menuone,noselect]])

--c-j c-k for moving in snippet
--let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
vim.cmd([[
  inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
  let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
  let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
  let g:UltiSnipsRemoveSelectModeMappings = 0
]])
