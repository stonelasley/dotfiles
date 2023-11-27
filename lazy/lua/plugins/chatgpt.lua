return {
  {
    "jackMort/ChatGPT.nvim",
    -- event = "VeryLazy",
    keys = {
      { "<leader>cc", "<cmd>ChatGPT<CR>", "ChatGpt" },
      { "<leader>ca", "<cmd>ChatGPTActAs<CR>", "Act As" },
      { "<leader>ce", "<cmd>ChatGPTEditWithInstructions<CR>", "Edit" },
      { "<leader>cr", "<cmd>ChatGPTRun<CR>", "Run" },
      { "<leader>cR", "<cmd>ChatGPTRunCustomCodeAction<CR>", "Run Custom Code Action" },
      { "<leader>cE", "<cmd>ChatGPTRunCustomCodeAction<CR>", mode = { "v" }, "Run Custom Code Action" },
    },
    opts = {
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
      openai_params = {
        model = "gpt-4-1106-preview",
      },
      openai_edit_params = {
        model = "code-davinci-edit-001",
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
}
