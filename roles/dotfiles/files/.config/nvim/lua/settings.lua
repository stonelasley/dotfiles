vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.wo.wrap = false
vim.opt.formatoptions = "cro"
vim.opt.clipboard:append("unnamedplus")
vim.opt.backupdir      = vim.fn.expand('~/.config/nvim/backup//') -- keep backup files out of the way (ie. if 'backup' is ever set)
vim.opt.backupdir      = vim.opt.backupdir + '.'
vim.opt.directory      = vim.fn.expand('~/.config/nvim/swap//')   -- keep swap files out of the way
vim.opt.directory      = vim.opt.directory + '.'



