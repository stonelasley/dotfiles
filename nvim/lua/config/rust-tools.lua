local extension_path = '/Users/scl/.vscode/extensions/vadimcn.vscode-lldb-1.6.8/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'

local opts = {
   -- ... other configs
    tools = {
      autoSetHints = true,
      runnables = {
        -- whether to use telescope for selection menu or not
        use_telescope = true
        -- rest of the opts are forwarded to telescope
      },
      debuggables = {
        -- whether to use telescope for selection menu or not
        use_telescope = true
        -- rest of the opts are forwarded to telescope
      },
    },
    dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(
            codelldb_path, liblldb_path)
    }
}
require('rust-tools').setup(opts)


-- Rust inlay hints
-- vim.api.nvim_exec(
--   [[
--   augroup RustTools
--     autocmd!
--     autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require('rust-tools.inlay_hints').set_inlay_hints() 
--     autocmd BufWritePre *.rs :lua vim.lsp.buf.formatting() 
--   augroup end
--   ]],
--   false
-- )
