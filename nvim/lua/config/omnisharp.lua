-- Highlight the completion documentation popup background/foreground the same as
-- the completion menu itself, for better readability with highlighted
-- documentation.
vim.g.omnicomplete_fetch_full_documentation = 1
vim.g.OmniSharp_autoselect_existing_sln = 1
vim.g.OmniSharp_popup_position = 'peek'
vim.g.OmniSharp_want_snippet=1
vim.g.OmniSharp_selector_ui = 'fzf'
vim.g.OmniSharp_selector_findusages = 'fzf'
vim.g.OmniSharp_highlighting = 0
--
vim.cmd([[
  let g:OmniSharp_diagnostic_exclude_paths = [ 'Temp[/\\]', 'obj[/\\]', '\.nuget[/\\]', 'Migrations\]' ]
  let g:OmniSharp_popup_mappings = { 'sigNext': '<C-n>', 'sigPrev': '<C-p>', 'lineDown': ['<C-e>', 'j'], 'lineUp': ['<C-y>', 'k'] }
  autocmd CursorHold *.cs OmniSharpTypeLookup
  autocmd BufWritePre *.cs :OmniSharpCodeFormat
]])

