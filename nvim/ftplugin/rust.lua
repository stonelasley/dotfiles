local vimp = require('vimp')
local dap = require('dap')
local rustRun = require('rust-tools.runnables')
local rustDebug = require('rust-tools.debuggables')
local dump = require('utils').dump
require('kartograaf').map({
  buffer = 0,
  n = {
    { '<F12>', '<cmd>lua vim.lsp.buf.formatting()<CR>' },
    { '<F11>', '<cmd>:lua require("dap").step_into()<CR>' },
    { '<F10>', '<cmd>:lua require("dap").step_over()<CR>' },
    { '<F9>', '<cmd>:lua require("dap").toggle_breakpoint()<CR>' },
    -- { '<M-F5>', '<cmd>lua require("rust-tools.runnables").runnables()<CR>' },
    { '<F6>', '<cmd>lua require("dap").status()<CR>' },
    { 'K', '<cmd>lua require("rust-tools.hover_actions").hover_actions()<CR>' }
  }
})

vimp.nnoremap({'buffer'}, '<F5>', function()

  if dap.status() == ''  then
    -- rustRun.runnables()
    rustDebug.debuggables()
  else
    dap.continue()
  end
  
end)