local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

augroup("st1", { clear = true })

autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch" }
  end,
  group = "st1",
})

-- autocmd("BufWritePre", {
--   pattern = { "*.rs", "*.lua", "*.vue", "*.ts" },
--   callback = function()
--     vim.lsp.buf.format()
--   end,
--   group = "st1",
-- })

autocmd("WinNew", {
  callback = function()
    vim.opt.laststatus = 3
  end,
  group = "st1",
})

vim.cmd [[ au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal ]]
--vim.cmd [[packadd packer.nvim]]
