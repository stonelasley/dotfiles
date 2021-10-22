require('kartograaf').map({
  buffer = 0,
  n = {
    { '<F12>', '<cmd>lua vim.lsp.buf.formatting()<CR>' },
    { '<F11>', '<cmd>:lua require("dap").step_into()<CR>' },
    { '<F10>', '<cmd>:lua require("dap").step_over()<CR>' },
    { '<F9>', '<cmd>:lua require("dap").toggle_breakpoint()<CR>' },
    { '<F5>', '<cmd>lua require("rust-tools.runnables").runnables()<CR>' },
    { 'K', '<cmd>lua require("rust-tools.hover_actions").hover_actions()<CR>' }
  }
})
