local nvim_lsp = require "lspconfig"
local buf_maps = require("mappings.lsp").set_buf_keymaps
local cmp = require "cmp_nvim_lsp"
local ls_configs = require "lsp"

for _, ls in ipairs(vim.tbl_keys(ls_configs)) do
  local config = ls_configs[ls]
  nvim_lsp[ls].setup {
    on_attach = function(client, bufnr)
      buf_maps(ls, bufnr)
      config.on_attach(client)
    end,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = cmp.update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    cmd = config.cmd,
    settings = config.settings,
  }
end
