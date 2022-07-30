local M = {}

M.volar = {
  cmd = { "volar-server", "--stdio" },
  settings = {},
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
  end,
}

local sumneko_root_path = "/opt/sumneko"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

M.sumneko_lua = {
  cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
  on_attach = function(client) end,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim", "print", "setmetatable", "pairs" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

M.tsserver = {
  cmd = { "typescript-language-server", "--stdio" },
  settings = {},
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
  end,
}

M.yamlls = {
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = true
  end,

  cmd = nil,
  settings = {},
}

local pid = vim.fn.getpid()
local omnisharp_bin = "/opt/omnisharp/run"

M.omnisharp = {
  on_attach = function(client) end,
  settings = {},
  cmd = {
    omnisharp_bin,
    "--languageserver",
    "--hostPID",
    tostring(pid),
  },
}
return M
