require("luasnip.loaders.from_lua").lazy_load {
  paths = "~/.config/nvim/lua/luasnippets",
}

local ls = require "luasnip"

ls.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
}

vim.keymap.set("i", "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)
