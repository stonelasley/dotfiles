local nvim_lsp = require('lspconfig')
local buf_maps = require('mappings.lsp').set_buf_keymaps
local cmp = require('cmp_nvim_lsp')

local servers = { 'vuels', 'tsserver', 'sumneko_lua', 'yamlls' }
-- 'rust_analyzer' is setup via rust-tools

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = cmp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, ls in ipairs(servers) do
  local mod_path = 'lsp.'..ls
  local config = require(mod_path)
  nvim_lsp[ls].setup {
    on_attach = function(client, bufnr)
      buf_maps(ls, bufnr)
      config.on_attach(client)
    end,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities,
    cmd = config.cmd,
    settings = config.settings
  }
end
