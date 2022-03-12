local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

augroup('st1', { clear = true })

autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch' })
  end,
  group = 'st1',
})

autocmd('CursorHold', {
  pattern = { '*.cs' },
  callback = function()
    vim.cmd([[
          :OmniSharpTypeLookup
        ]])
  end,
  group = 'st1',
})

-- TODO
-- cmd "autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)"
-- cmd "autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)"

autocmd('BufWritePre', {
  pattern = { '*.cs' },
  callback = function()
    vim.cmd([[
          :OmniSharpCodeFormat
        ]])
  end,
  group = 'st1',
})

autocmd('BufWritePre', {
  pattern = { '*.rs', '*.lua' },
  callback = function()
    vim.lsp.buf.formatting()
  end,
  group = 'st1',
})

autocmd('BufEnter,BufWinEnter,TabEnter', {
  pattern = '*.rs',
  callback = function()
    require('rust-tools.inlay_hints').set_inlay_hints()
  end,
  group = 'st1',
})

vim.cmd([[ au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal ]])
