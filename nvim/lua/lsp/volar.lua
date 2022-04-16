local M = {}

function M.on_attach(client)
  client.resolved_capabilities.document_formatting = false
end

M.cmd = { "volar-server", "--stdio" }
M.settings = {}
return M
