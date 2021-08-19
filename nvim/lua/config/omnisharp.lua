-- Highlight the completion documentation popup background/foreground the same as
-- the completion menu itself, for better readability with highlighted
-- documentation.
vim.g.completeopt='longest,menuone,preview'
vim.g.OmniSharp_want_snippet=1
vim.g.omnicomplete_fetch_full_documentation = 1
vim.g.OmniSharp_autoselect_existing_sln = 1
vim.g.OmniSharp_popup_position = 'peek'

vim.cmd([[
  let g:OmniSharp_diagnostic_exclude_paths = [ 'Temp[/\\]', 'obj[/\\]', '\.nuget[/\\]' ]
  autocmd CursorHold *.cs OmniSharpTypeLookup
  autocmd BufWritePre *.cs :OmniSharpCodeFormat
]])
