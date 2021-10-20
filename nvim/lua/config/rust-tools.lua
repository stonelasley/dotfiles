local rust_tools = require('reust-tools')
local extension_path = '/Users/scl/.vscode/extensions/vadimcn.vscode-lldb-1.6.8/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'
local dap_adapter = require('rust-tools.dap').get_codelldb_adapter

rust_tools.setup({
   tools = {
      autoSetHints = true,
      runnables = {
         use_telescope = true
      },
      debuggables = {
         use_telescope = true
      },
   },
   dap = {
      adapter = dap_adapter(codelldb_path, liblldb_path)
   }
})

-- autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require('rust-tools.inlay_hints').set_inlay_hints() 
vim.api.nvim_exec(
[[
  augroup RustTools
    autocmd!
    autocmd BufWritePre *.rs :lua vim.lsp.buf.formatting() 
  augroup end
]],
false
)
