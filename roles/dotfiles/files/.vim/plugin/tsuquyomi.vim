"/* ---------------------- Tsuquyomi ------------------------- */
let g:syntastic_typescript_checkers = ['tslint','tsuquyomi']
let g:tsuquyomi_disable_quickfix = 1
let g:tsuquyomi_shortest_import_path = 1
let g:tsuquyomi_single_quote_import = 1
let g:tsuquyomi_completion_detail = 1
nnoremap <Leader>i :TsuImport<CR>
nnoremap <Leader>r :TsuRenameSymbol<CR>
nnoremap <Leader>d :TsuDefinition<CR>

