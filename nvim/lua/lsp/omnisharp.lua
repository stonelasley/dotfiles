local M = {}
local pid = vim.fn.getpid()
local omnisharp_bin = "/opt/omnisharp/run"

function M.on_attach (client)
end

M.settings = {}

M.cmd = {
    omnisharp_bin,
    "--languageserver" ,
    "--hostPID",
    tostring(pid)
  }

return M
