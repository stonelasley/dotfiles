local M = {}
function M.on_attach(client)
    client.resolved_capabilities.document_formatting = true
end

M.cmd = { 'rust-analyzer' }
M.settings = {}

return M
--require('lspconfig').rust_analyzer.setup({})
