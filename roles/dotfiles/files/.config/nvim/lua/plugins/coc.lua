local utils = require('utils')

-- TextEdit might fail if hidden is not set.
utils.opt('o', 'hidden', true)
-- Some servers have issues with backup files, see #649.
utils.opt('o', 'backup', false)
utils.opt('o', 'writebackup', false)

-- Give more space for displaying messages.
utils.opt('o', 'cmdheight', 2)

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
utils.opt('o', 'updatetime', 300)

-- Don't pass messages to |ins-completion-menu|.
vim.o.shortmess = vim.o.shortmess ..'c'

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
utils.opt('o', 'signcolumn', 'number')

-- Use <c-space> to trigger completion.
utils.map('i', '<c-space>', 'coc#refresh()', { silent = true, expr = true })

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
utils.map('n', '[g', '<Plug>(coc-diagnostic-prev)', { silent = true })
utils.map('n', ']g', '<Plug>(coc-diagnostic-next)', { silent = true })

-- GoTo code navigation.
utils.map('n', 'gd', '<Plug>(coc-definition)', { silent = true })
utils.map('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
utils.map('n', 'gi', '<Plug>(coc-implementation)', { silent = true })
utils.map('n', 'gr', '<Plug>(coc-references)', { silent = true })

-- TODO - ERROR <SID> not in a script context
-- Use K to show documentation in preview window.
-- utils.map('n', '<silent> K', ':call <SID>show_documentation()<CR>')

-- Symbol renaming.
utils.map('n', '<leader> rn', '<Plug>(coc-rename)')

-- Formatting selected code.
utils.map('x', '<leader>f', '<Plug>(coc-format-selected)')
utils.map('n', '<leader>f', '<Plug>(coc-format-selected)')
utils.map('v', '<leader>f', '<Plug>(coc-format-selected)')

-- Applying codeAction to the selected region.
-- Example: `<leader>aap` for current paragraph
utils.map('x', '<leader>a', '<Plug>(coc-codeaction-selected)')
utils.map('n', '<leader>a', '<Plug>(coc-codeaction-selected)')

-- Remap keys for applying codeAction to the current buffer.
utils.map('n', '<leader>ac', '<Plug>(coc-codeaction)')
-- Apply AutoFix to problem on the current line.
utils.map('n', '<leader>qf', '<Plug>(coc-fix-current)')

-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
utils.map('x', 'if', '<Plug>(coc-funcobj-i)')
utils.map('o', 'if', '<Plug>(coc-funcobj-i)')
utils.map('x', 'af', '<Plug>(coc-funcobj-a)')
utils.map('o', 'af', '<Plug>(coc-funcobj-a)')
utils.map('x', 'ic', '<Plug>(coc-classobj-i)')
utils.map('o', 'ic', '<Plug>(coc-classobj-i)')
utils.map('x', 'ac', '<Plug>(coc-classobj-a)')
utils.map('o', 'ac', '<Plug>(coc-classobj-a)')

-- Remap <C-f> and <C-b> for scroll float windows/popups.
utils.map('n', '<C-f>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', { noremap = true, silent = true, nowait = true, expr = true})
utils.map('n', '<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', { noremap = true, silent = true, nowait = true, expr = true})
utils.map('i', '<C-f>', 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', { noremap = true, silent = true, nowait = true, expr = true})
utils.map('i', '<C-b>', 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', { noremap = true, silent = true, nowait = true, expr = true})
utils.map('v', '<C-f>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', { noremap = true, silent = true, nowait = true, expr = true})
utils.map('v', '<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', { noremap = true, silent = true, nowait = true, expr = true})

-- Use CTRL-S for selections ranges.
-- Requires 'textDocument/selectionRange' support of language server.
utils.map('n', '<C-s>', '<Plug>(coc-range-select)', { silent = true })
utils.map('x', '<C-s>', '<Plug>(coc-range-select)', { silent = true })

-- Mappings for CoCList
-- Show all diagnostics.
utils.map('n', '<space>a', ':<C-u>CocList diagnostics<cr>', { silent = true, nowait = true })
utils.map('n', '<space>e', ':<C-u>CocList extensions<cr>', { silent = true, nowait = true })
utils.map('n', '<space>c', ':<C-u>CocList commands<cr>', { silent = true, nowait = true })
utils.map('n', '<space>o', ':<C-u>CocList outline<cr>', { silent = true, nowait = true })
utils.map('n', '<space>s', ':<C-u>CocList -I symbols<cr>', { silent = true, nowait = true })
utils.map('n', '<space>j', ':<C-u>CocNext<CR>', { silent = true, nowait = true })
utils.map('n', '<space>k', ':<C-u>CocPrev<CR>', { silent = true, nowait = true })
utils.map('n', '<space>p', ':<C-u>CocListResume<CR>', { silent = true, nowait = true })
