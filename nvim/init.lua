local present, impatient = pcall(require, 'impatient')

if present then
  impatient.enable_profile()
end

require('st1.options')
require('plugins')
require('st1.au')

vim.g.mapleader = ' '
