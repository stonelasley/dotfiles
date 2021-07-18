local cmd = vim.cmd
require('mappings.coc')
require('mappings.coc-prettier')
require('mappings.hop')
require('mappings.normal')
require('mappings.global')
require('mappings.nvim-tree')
require('mappings.telescope')

-- Commands
cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
cmd [[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
cmd [[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
cmd [[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]]
