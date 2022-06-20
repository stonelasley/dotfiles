local opt = vim.opt
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup


augroup("st1", { clear = true })

autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch" }
  end,
  group = "st1",
})

--autocmd("BufWritePre", {
--  pattern = { "*.rs", "*.lua", "*.vue", "*.ts" },
--  callback = function()
--    vim.lsp.buf.formatting()
--  end,
--  group = "st1",
--})

autocmd("BufEnter,BufWinEnter,TabEnter", {
  pattern = "*.rs",
  callback = function()
    require("rust-tools.inlay_hints").set_inlay_hints()
  end,
  group = "st1",
})

autocmd("WinNew", {
  callback = function()
    opt.laststatus = 3
  end,
  group = "st1",
})

autocmd("InsertEnter", {
  callback = function()
    opt.relativenumber = false
  end,
  group = "st1",
})

autocmd("InsertLeave", {
  callback = function()
    opt.relativenumber = true
  end,
  group = "st1",
})

vim.cmd [[ au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal ]]
