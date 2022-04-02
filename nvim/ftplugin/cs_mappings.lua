require('kartograaf').map({
  buffer = 0,
  options = { silent = true, noremap = false },
  n = {
    {
      prefix = 'g',
      { 'd', '<Plug>(omnisharp_go_to_definition)' },
      { 'D', '<Plug>(omnisharp_preview_definition)' },
      { 'i', '<Plug>(omnisharp_find_implementations)' },
      { 'I', '<Plug>(omnisharp_preview_implementations)' },
      { 'u', '<Plug>(omnisharp_find_usages)' },
    },
    {
      prefix = '<Leader>',
      { 'ost', '<Plug>(omnisharp_type_lookup)' },
      { 'osd', '<Plug>(omnisharp_documentation)' },
      { 'osfs', '<Plug>(omnisharp_find_symbol)' },
      { 'os.', '<Plug>(omnisharp_code_actions_repeat)' },
      { 'osre', '<Plug>(omnisharp_restart_server)' },
      { 'osst', '<Plug>(omnisharp_start_server)' },
      { 'ossp', '<Plug>(omnisharp_stop_server)' },
      { '<leader>fu', '<Plug>(omnisharp_fix_usings)' },
      { '<leader>.', '<Plug>(omnisharp_code_actions)' },
    },
    { 'K', '<Plug>(omnisharp_type_lookup)' },
    { [[<C-\>]], [[<Plug>(omnisharp_signature_help)]] },
    { '<F2>', [[<Plug>(omnisharp_rename)]] },
    { '<F12>', [[<Plug>(omnisharp_code_format)]] },
  },
  i = {
    {
      prefix = '<Leader>',
      --{ 'osgcc', [[<Plug>(omnisharp_global_code_check)]] },
    },
    { [[<C-\>]], [[<Plug>(omnisharp_signature_help)]] },
    { '<F12>', [[<Plug>(omnisharp_code_format)]] },
  },
  x = {
    prefix = '<Leader>',
    { 'osgcc', [[<Plug>(omnisharp_global_code_check)]] },
    { 'os.', '<Plug>(omnisharp_code_actions_repeat)' },
    { '<F12>', [[<Plug>(omnisharp_code_format)]] },
  },
})
