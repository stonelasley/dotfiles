local rust_tools = require('rust-tools')
local extension_path = '/Users/scl/.vscode/extensions/vadimcn.vscode-lldb-1.6.8/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'
local dap_adapter = require('rust-tools.dap').get_codelldb_adapter
local cmp = require('cmp_nvim_lsp')

rust_tools.setup({
    tools = {
        autoSetHints = true,
        runnables = {
            use_telescope = true,
        },
        debuggables = {
            use_telescope = true,
        },
    },
    dap = {
        adapter = dap_adapter(codelldb_path, liblldb_path),
    },
    server = {
        capabilities = cmp.update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    },
})
