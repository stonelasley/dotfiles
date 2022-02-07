local M = {}

function M.on_attach(client)
    client.resolved_capabilities.document_formatting = false
end

M.cmd = { "typescript-language-server", "--stdio" }
M.settings = {}

return M
