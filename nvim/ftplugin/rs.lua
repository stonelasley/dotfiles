require('kartograaf').map({
  n = {
    { '<F12>', '<cmd>lua vim.lsp.buf.formatting()<CR>' },
    { '<F5>', '<cmd>lua require("rust-tools.runnables").runnables()<CR>' },
    { 'K', '<cmd>lua require("rust-tools.hover_actions").hover_actions()<CR>' },
  }
})
