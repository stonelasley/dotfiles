local M = {}
local sumneko_root_path = "/opt/sumneko"

local function system_name()
    local has = vim.fn.has
    if has("mac") == 1 then
        return ""
    elseif has("unix") == 1 then
        return "Linux/"
    elseif has("win32") == 1 then
        return "Windows/"
    else
        print("Unsupported system for sumneko")
        return ""
    end
end
local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name() .. "lua-language-server"

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

M.cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" }

M.on_attach = function(client) end

M.settings = {
    Lua = {
        runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
            -- Setup your lua path
            path = runtime_path,
        },
        diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim" },
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
}

return M
