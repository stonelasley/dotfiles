local map = require('utils').buf_map
-- Omnisharp
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
map(0, 'n', '<F12>', [[<Plug>(omnisharp_code_format)]], silent)
map(0, 'i', '<F12>', [[<Plug>(omnisharp_code_format)]], silent)
map(0, 'x', '<F12>', [[<Plug>(omnisharp_code_format)]], silent)
map(0, 'n', '<C-r><C-r>', [[<Plug>(omnisharp_rename)]], silent)
map(0, 'n', '<Leader><Leader>.', [[<Plug>(omnisharp_code_actions)]], silent)
map(0, 'i', '<Leader>osgcc', [[<Plug>(omnisharp_global_code_check)]], silent)
map(0, 'n', '<Leader>os.', [[<Plug>(omnisharp_code_actions_repeat)]], silent)
map(0, 'x', '<Leader>os.', [[<Plug>(omnisharp_code_actions_repeat)]], silent)
map(0, 'n', '<Leader>osre', [[<Plug>(omnisharp_restart_server)]], silent)
map(0, 'n', '<Leader>osst', [[<Plug>(omnisharp_start_server)]], silent)
map(0, 'n', '<Leader>ossp', [[<Plug>(omnisharp_stop_server)]], silent)
