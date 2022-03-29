-- Highlight the completion documentation popup background/foreground the same as
-- the completion menu itself, for better readability with highlighted
-- documentation.
--
vim.cmd([[
  let g:OmniSharp_server_use_net6 = 1
  let g:OmniSharp_selector_ui = 'fzf'
  let g:OmniSharp_selector_findusages = 'fzf'
  let g:omnicomplete_fetch_full_documentation = 1
  let g:OmniSharp_autoselect_existing_sln = 1
  let g:OmniSharp_popup_position = 'peek'
  let g:OmniSharp_want_snippet = 1
  let g:mniSharp_highlighting = 0
  let g:OmniSharp_diagnostic_exclude_paths = [ 'Temp[/\\]', 'obj[/\\]', '\.nuget[/\\]', 'Migrations\]' ]
  let g:OmniSharp_popup_mappings = { 'sigNext': '<C-n>', 'sigPrev': '<C-p>', 'lineDown': ['<C-e>', 'j'], 'lineUp': ['<C-y>', 'k'] }
]])
