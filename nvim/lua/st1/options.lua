local g = vim.g
local cmd = vim.cmd
local utils = require "utils"

cmd [[
  set rtp+=/opt/fzf
  set ffs=unix,dos
  set ff=unix
]]

utils.opt({ "o", "b" }, "expandtab", true)
utils.opt({ "o", "b" }, "smartindent", true)
utils.opt({ "o", "b" }, "textwidth", 100)
utils.opt({ "o", "w" }, "number", true)
utils.opt({ "o", "w" }, "relativenumber", true)
utils.opt("o", "splitbelow", true)
utils.opt("o", "splitright", true)
utils.opt("w", "wrap", false)
utils.opt("o", "formatoptions", "cro")
utils.opt("o", "termguicolors", true)

vim.opt.clipboard:append "unnamedplus"
vim.g.indentLine_fileTypeExclude = { "json" }
vim.g.wrap = false
vim.g.ttimeoutlen = 100
vim.g.guicursor = "blinkon100"
vim.o.completeopt = "menuone,noinsert,noselect"

local disabled_plugins = {
  "2html_plugin",
  "did_load_filetypes",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
}

for _, plugin in pairs(disabled_plugins) do
  g["loaded_" .. plugin] = 1
end
vim.g.mapleader = " "
