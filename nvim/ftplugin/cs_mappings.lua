local map = require('utils').buf_map
local cmd = vim.cmd
-- Omnisharp
-- TODO: these aren't loading working when in omnisharp mapping
-- cmd [[autocmd FileType cs nmap <silent> <buffer> <Leader><Leader>. <Plug>(omnisharp_code_actions)]]
-- cmd [[autocmd FileType cs xmap <silent> <buffer> <Leader><Leader>. <Plug>(omnisharp_code_actions)]]
-- cmd "autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)"
-- cmd "autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)"

local silent = { noremap = false, silent = true}
map(0, 'n', 'gd', '<Plug>(omnisharp_go_to_definition)', silent)
map(0, 'n', 'gi', '<Plug>(omnisharp_find_implementations)', silent)
map(0, 'n', '<Leader>osfu', '<Plug>(omnisharp_find_usages)', silent)
map(0, 'n', '<Leader>ospd', '<Plug>(omnisharp_preview_definition)', silent)
map(0, 'n', '<Leader>ospi', '<Plug>(omnisharp_preview_implementations)', silent)
map(0, 'n', '<Leader>ost', '<Plug>(omnisharp_type_lookup)', silent)
map(0, 'n', '<Leader>osd', '<Plug>(omnisharp_documentation)', silent)
map(0, 'n', '<Leader>osfs', '<Plug>(omnisharp_find_symbol)', silent)
map(0, 'n', '<Leader><Leader>fu', '<Plug>(omnisharp_fix_usings)', silent)
map(0, 'n', [[<C-\>]], [[<Plug>(omnisharp_signature_help)]], silent)
map(0, 'i', [[<C-\>]], [[<Plug>(omnisharp_signature_help)]], silent)
cmd [[
  augroup omnisharp_commands
    autocmd!
    " Show type information automatically when the cursor stops moving.
    " Note that the type is echoed to the Vim command line, and will overwrite
    " any other messages in this space including e.g. ALE linting messages.
    
    " The following commands are contextual, based on the cursor position.
    " nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
    " nmap <silent> <buffer> gi <Plug>(omnisharp_find_implementations)
    " nmap <silent> <buffer> <Leader>osfu <Plug>(omnisharp_find_usages)
    " nmap <silent> <buffer> <Leader>ospd <Plug>(omnisharp_preview_definition)
    " nmap <silent> <buffer> <Leader>ospi <Plug>(omnisharp_preview_implementations)
    " nmap <silent> <buffer> <Leader>ost <Plug>(omnisharp_type_lookup)
    " nmap <silent> <buffer> <Leader>osd <Plug>(omnisharp_documentation)
    " nmap <silent> <buffer> <Leader>osfs <Plug>(omnisharp_find_symbol)
    " nmap <silent> <buffer> <Leader><Leader>fu <Plug>(omnisharp_fix_usings)
    " nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
    " imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
    

    nmap <silent> <buffer> <Leader>osgcc <Plug>(omnisharp_global_code_check)
    nmap <silent> <buffer> <Leader><Leader>. <Plug>(omnisharp_code_actions)
    xmap <silent> <buffer> <Leader><Leader>. <Plug>(omnisharp_code_actions)
    nmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)
    xmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)
    nmap <silent> <buffer> <Leader><Leader>p <Plug>(omnisharp_code_format)
    nmap <silent> <buffer> <C-r><C-r> <Plug>(omnisharp_rename)
    "autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
    "autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
    "autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)
  augroup END
]]
