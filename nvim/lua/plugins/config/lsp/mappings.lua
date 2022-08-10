local M = {}

local whichkey = require "which-key"
local maps = require('mappings/lsp')

function M.setup(client, bufnr)
  maps.setup(client, bufnr)
  -- signature_help(client, bufnr) -- use cmp-nvim-lsp-signature-help
  local o = { buffer = bufnr, prefix = "<leader>" }
  whichkey.register(maps.n, o)
  o = { mode = "v", buffer = bufnr, prefix = "<leader>" }
  whichkey.register(maps.v, o)
  o = { buffer = bufnr, prefix = "g" }
  whichkey.register(maps.g, o)
end

return M
