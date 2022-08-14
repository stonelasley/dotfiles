local M = {}
local utils = require "utils"

-- local util = require "lspconfig.util"

local servers = {
  html = {},
  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
      },
    },
  },
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        cargo = { allFeatures = true },
        checkOnSave = {
          command = "clippy",
          extraArgs = { "--no-deps" },
        },
      },
    },
  },
  ["sumneko_lua"] = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
          path = vim.split(package.path, ";"),
        },
        diagnostics = {
          globals = {
            "vim",
            "describe",
            "it",
            "before_each",
            "after_each",
            "packer_plugins",
          },
        },
        format = {
          enable = false,
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
            [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          },
          -- library = vim.api.nvim_get_runtime_file("", true),
          maxPreload = 2000,
          preloadFileSize = 50000,
        },
        completion = { callSnippet = "Both" },
        telemetry = { enable = false },
      },
    },
  },
  tsserver = { disable_formatting = true },
  vimls = {},
  --tailwindcss = {},
  yamlls = {
    schemastore = {
      enable = true,
    },
    settings = {
      yaml = {
        hover = true,
        completion = true,
        validate = true,
        schemas = require("schemastore").json.schemas(),
      },
    },
  },
  dockerls = {},
  bashls = {},
  omnisharp = {
    handlers = {
      ["textDocument/definition"] = require("omnisharp_extended").handler,
    },
  },
  --emmet_ls = {},
  --marksman = {},
  angularls = {},
  vue_language_server = {},
}

function M.on_attach(client, bufnr)
  -- Enable completion triggered by <C-X><C-O>
  -- See `:help omnifunc` and `:help ins-completion` for more information.
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Use LSP as the handler for formatexpr.
  -- See `:help formatexpr` for more information.
  vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  -- Configure key mappings
  require("plugins.config.lsp.mappings").setup(client, bufnr)

  -- Configure highlighting
  require("plugins.config.lsp.highlighter").setup(client, bufnr)

  -- Configure formatting
  require("plugins.config.lsp.null-ls.formatters").setup(client, bufnr)

  -- tagfunc

  if client.server_capabilities.definitionProvider then
    vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
  end

  -- aerial.nvim
  -- require("aerial").on_attach(client, bufnr)

  -- nvim-navic
  --if client.server_capabilities.documentSymbolProvider then
  --  local navic = require "nvim-navic"
  --  navic.attach(client, bufnr)
  --end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}
M.capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities) -- for nvim-cmp

local opts = {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

-- Setup LSP handlers
require("plugins.config.lsp.handlers").setup()

function M.setup()
  -- null-ls
  require("plugins.config.lsp.null-ls").setup(opts)

  -- Installer
  require("plugins.config.lsp.installer").setup(servers, opts)

  -- Inlay hints
  require("plugins.config.lsp.inlay-hints").setup()
end

local diagnostics_active = true

function M.toggle_diagnostics()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.show()
  else
    vim.diagnostic.hide()
  end
end

function M.remove_unused_imports()
  vim.diagnostic.setqflist { severity = vim.diagnostic.severity.WARN }
  vim.cmd "packadd cfilter"
  vim.cmd "Cfilter /main/"
  vim.cmd "Cfilter /The import/"
  vim.cmd "cdo normal dd"
  vim.cmd "cclose"
  vim.cmd "wa"
end

return M
