local wk = require "which-key"
local maps = require "mappings"

local conf = {
  window = {
    border = "single", -- none, single, double, shadow
    position = "bottom", -- bottom, top
  },
  ignore_missing = true,
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ ", "<Plug>" },
}

wk.setup(conf)
wk.register(maps.normal)
wk.register(maps.command, { mode = "c" })
wk.register(maps.terminal, { mode = "t" })
wk.register(maps.normal_leader, { mode = "n", prefix = "<Leader>" })
wk.register(maps.vis_sel_leader, { mode = "v", prefix = "<Leader>" })
wk.register(maps.visual_leader, { mode = "x", prefix = "<Leader>" })
