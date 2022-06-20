local M = {}

M.setup_lsp = function(attach, capabilities)
  local lspconfig = require "lspconfig"

  -- lspservers with default config
  local servers = {
    "html",
    "cssls",
    "clangd",
    "rust_analyzer",
    "sumneko_lua",
    "omnisharp",
    "tsserver",
    "volar",
    "yamlls",
    "bash_ls",
    "dockerls",
    "eslint",
    "grammarly",
    "jsonls"
  }

  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      on_attach = attach,
      capabilities = capabilities,
    }
  end
end

return M
