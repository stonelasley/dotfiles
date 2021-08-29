-- Omnisharp
-- TODO
-- cmd "autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)"
-- cmd "autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)"
--
require('kartograaf').map({
  buffer = 0,
  options = { silent = true, noremap = false },
  n = {
    {
      prefix = 'g',
      { 'd', '<Plug>(omnisharp_go_to_definition)'},
      { 'i', '<Plug>(omnisharp_find_implementations)'},
    },
    {
      prefix = '<Leader>',
      { 'osfu', '<Plug>(omnisharp_find_usages)' },
      { 'ospd', '<Plug>(omnisharp_preview_definition)' },
      { 'ospi', '<Plug>(omnisharp_preview_implementations)' },
      { 'ost',  '<Plug>(omnisharp_type_lookup)' },
      { 'osd',  '<Plug>(omnisharp_documentation)' },
      { 'osfs', '<Plug>(omnisharp_find_symbol)' },
      { 'os.',  '<Plug>(omnisharp_code_actions_repeat)' },
      { 'osre', '<Plug>(omnisharp_restart_server)' },
      { 'osst', '<Plug>(omnisharp_start_server)' },
      { 'ossp', '<Plug>(omnisharp_stop_server)' },
      { '<leader>fu', '<Plug>(omnisharp_fix_usings)' },
      { '<leader>.', '<Plug>(omnisharp_code_actions)' },
    },
    { [[<C-\>]], [[<Plug>(omnisharp_signature_help)]] },
    { '<F12>', [[<Plug>(omnisharp_code_format)]] },
    { '<C-r><C-r>', [[<Plug>(omnisharp_rename)]] }
  },
  i = {
    {
      prefix = '<Leader>', { 'osgcc' , [[<Plug>(omnisharp_global_code_check)]] }
    },
    { [[<C-\>]], [[<Plug>(omnisharp_signature_help)]] },
    { '<F12>', [[<Plug>(omnisharp_code_format)]] }
  },
  x = {
    prefix = '<Leader>',
    { 'osgcc' , [[<Plug>(omnisharp_global_code_check)]] },
    { 'os.', '<Plug>(omnisharp_code_actions_repeat)' },
    { '<F12>', [[<Plug>(omnisharp_code_format)]] }
  }
})
