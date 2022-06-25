-- Just an example, supposed to be placed in /lua/custom/
local hl_override = require('custom.highlights')
local plugin_override = require('custom.overrides')

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.ui = {
  theme = "nord",
  hl_override = hl_override
}

M.plugins = {
  user = require "custom.plugins",
  options = {
    lspconfig = {
      setup_lspconf = "custom.plugins.lspconfig"
    }
  },
  override = {
    ["nvim-treesitter/nvim-treesitter"] = plugin_override.treesitter
  }

}


M.mappings = require "custom.mappings"

return M
