local chatgpt = require "chatgpt"
local M = {}

M.mappings = function()
  chatgpt.edit_with_instructions()
end

M.setup = function()
  chatgpt.setup {
    chat = {
      keymaps = {
        close = { "jk", "kj", "<Esc>" },
        yank_last = "<C-y>",
        scroll_up = "<C-u>",
        scroll_down = "<C-d>",
        toggle_settings = "<C-o>",
        new_session = "<C-n>",
        cycle_windows = "<Tab>",
      },
    },
    popup_input = {
      submit = "<C-s>",
    },
  }
end

return M
