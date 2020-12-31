"/* ---------------------- UltiSnips -------------------------- */
"let g:UltiSnipsExpandTrigger="<nop>"
"let g:ulti_expand_or_jump_res=0
"let g:UltiSnipsJumpForwardTrigger="<Tab>"
"let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
"let g:UltiSnipsMappingsToIgnore=['autocomplete']
"let g:UltiSnipsEditSplit = 'vertical'
"let g:UltiSnipsSnippetDirectories = ["~/.vim/UltiSnips"]
"function ExpandSnipOrCarriageReturn()
"  let snippet = UltiSnips#ExpandSnippetOrJump()
"  echo g:ulti_expand_or_jump_res
"  if g:ulti_expand_or_jump_res > 0
"    return snippet
"  else
"    return "\<CR>"
"  endi
"endfunction
"inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnipOrCarriageReturn()<CR>" : "\<CR>"
