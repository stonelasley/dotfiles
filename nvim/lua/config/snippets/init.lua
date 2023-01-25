local M = {}

local snippets_folder = vim.fn.stdpath "config" .. "/lua/config/snippets/templates/"
local ls = require "luasnip"
local types = require "luasnip.util.types"

function M.setup()
  ls.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = false,
    store_selection_keys = "<C-q>",
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { "●", "WarningMsg" } },
        },
      },
      [types.insertNode] = {
        active = {
          virt_text = { { "●", "MoreMsg" } },
        },
      },
    },
  }

  -- Lazy load snippets
  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_snipmate").lazy_load()
  require("luasnip.loaders.from_lua").lazy_load { paths = snippets_folder }

  vim.cmd [[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]

  -- Load custom snippets
  require("luasnip.loaders.from_vscode").lazy_load { paths = { "./templates/typescript" } }
  -- require("luasnip.loaders.from_vscode").lazy_load { paths = { "./templates/cs" } }
  require("luasnip.loaders.from_vscode").lazy_load { paths = { "./templates/rust" } }

  ls.filetype_extend("all", { "_" })
end

return M
