local M = {}

M.setup = function()
  vim.cmd [[
  let g:copilot_filetypes = {
    \ 'telescope': v:false,
    \ 'TelescopePrompt': v:false,
    \ 'TelescopeResult': v:false,
    \ 'help': v:false,
    \ }
  imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
  let g:copilot_no_tab_map = v:true

  ]]
end

return M
