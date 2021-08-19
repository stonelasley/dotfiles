local map = require('utils').map
local opt = { noremap = false}

map('n', 'gd', '<Plug>(omnisharp_go_to_definition)', opt)
map('n', 'gi', '<Plug>(omnisharp_find_implementations)', opt)
map('n', 'K', '<Plug>(omnisharp_documentation)', opt)
map('n', '<C-r><C-r>', '<Plug>(omnisharp_rename)', opt)
map('n', '<Leader>cf', '<Plug>(omnisharp_code_format)', opt)
map('n', '<Leader>fs', '<Plug>(omnisharp_find_symbol)', opt)
map('n', '<Leader>fu', '<Plug>(omnisharp_find_usages)', opt)
map('n', '<Leader>cc', '<Plug>(omnisharp_global_code_check)', opt)
map('n', '<Leader>rt', '<Plug>(omnisharp_run_test)', opt)
map('n', '<Leader>rT', '<Plug>(omnisharp_run_tests_in_file)', opt)
map('n', '<Leader>ss', '<Plug>(omnisharp_start_server)', opt)
map('n', '<Leader>sp', '<Plug>(omnisharp_stop_server)', opt)
map('n', [[<C-\>]], '<Plug>(omnisharp_signature_help', opt)
map('i', [[<C-\>]], '<Plug>(omnisharp_signature_help', opt)
