local cmd = vim.cmd
vim.api.nvim_command('let &packpath = &runtimepath')
require('plugins')
require('mappings')
require('config')

-- AutoCommands
-- au! BufWritePost $MYVIMRC source %

-- Highlight text on yank
-- vim.api.nvim_command("au TextYankPost * silent! lua require'vim.highlight'.on_yank()")
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
  ]],
  false
)

-- Commands

-- Packer
cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
cmd [[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
cmd [[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
cmd [[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]]

