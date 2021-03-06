local opt = require('utils').opt

-- TextEdit might fail if hidden is not set.
opt('o', 'hidden', true)
-- Some servers have issues with backup files, see #649.
opt('o', 'backup', false)
opt('o', 'writebackup', false)

-- Give more space for displaying messages.
opt('o', 'cmdheight', 2)

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
opt('o', 'updatetime', 300)

-- Don't pass messages to |ins-completion-menu|.
vim.o.shortmess = vim.o.shortmess ..'c'

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
opt('o', 'signcolumn', 'number')


