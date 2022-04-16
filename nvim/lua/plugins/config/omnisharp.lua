-- Highlight the completion documentation popup background/foreground the same as
-- the completion menu itself, for better readability with highlighted
-- documentation.
--
vim.cmd [[
  let g:OmniSharp_server_use_net6 = 1
  let g:OmniSharp_selector_ui = 'fzf'
  let g:OmniSharp_selector_findusages = 'fzf'
  let g:omnicomplete_fetch_full_documentation = 1
  let g:OmniSharp_autoselect_existing_sln = 1
  let g:OmniSharp_popup_position = 'atcursor'
  let g:OmniSharp_want_snippet = 1
  let g:OmniSharp_highlighting = 1
  let g:OmniSharp_diagnostic_exclude_paths = [ 'Temp[/\\]', 'obj[/\\]', '\.nuget[/\\]', 'Migrations\]' ]
  let g:OmniSharp_popup_mappings = { 'sigNext': '<C-n>', 'sigPrev': '<C-p>', 'lineDown': ['<C-e>', 'j'], 'lineUp': ['<C-y>', 'k'] }
  
  let g:OmniSharp_highlight_groups = {
  \ 'Comment': 'TSComment',
  \ 'FieldName' : 'TSField',
  \ 'MethodName' : 'TSMethod',
  \ 'ExtentionMethodName' : 'TSFunction',
  \ 'Operator' : 'TSOperator',
  \ 'Keyword' : 'TSKeyword',
  \ 'StringLiteral' : 'TSString',
  \ 'LocalName' : 'TSTitle',
  \ 'PropertyName' : 'TSProperty',
  \ 'VerbatimeStringLiteral' : 'TSLiteral',
  \ 'EnumName' : 'TSType',
  \ 'Punctuation' : 'TSPunctSpecial',
  \ 'ClassName' : 'TSTypeBuiltin',
  \ 'RecordName' : 'TSType',
  \ 'StructName' : 'TSType',
  \ 'ConstantName' : 'TSConstant',
  \ 'NamespaceName' : 'TSInclude',
  \ 'ParameterName' : 'TSParameter',
  \ 'XmlDocCommentName': 'Identifier',
  \ 'XmlDocCommentText': 'NonText',
  \ 'LabelName': 'TSLabel',
  \}
]]
