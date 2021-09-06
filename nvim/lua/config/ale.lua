vim.g.ale_disable_lsp = 1
vim.g.ale_set_highlights = 0
-- vim.g.ale_lint_on_text_changed = 'never'
-- vim.g.ale_lint_on_insert_leave = 1
-- vim.g.ale_lint_on_enter = 1
vim.cmd([[ "let g:ale_linters = { 'cs': ['omnisharp'] } ]])
