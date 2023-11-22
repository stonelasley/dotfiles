-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- INSERT
vim.keymap.set("i", "jk", "<Esc>")
-- NORMAL
vim.keymap.set("n", "y", '"+y')
vim.keymap.set("n", "_d", '"_d')
vim.keymap.set("n", "Y", 'ggj"+yG')
-- VISUAL
