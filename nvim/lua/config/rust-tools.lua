require('rust-tools').setup({})
-- Rust inlay hints
vim.api.nvim_exec(
  [[
  augroup RustTools
    autocmd!
    autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require('rust-tools.inlay_hints').set_inlay_hints() 
  augroup end
  ]],
  false
)


