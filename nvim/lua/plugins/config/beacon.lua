vim.api.nvim_exec(
  [[
    let g:beacon_size = 20
    let g:beacon_show_jumps = 1
    let g:beacon_minimal_jump = 10
    let g:beacon_shrink = 1
    let g:beacon_fade = 1
    let g:beacon_ignore_buffers = [\w*git*\w]
    let g:beacon_ignore_filetypes = ['fzf']
  ]],
  false
)
