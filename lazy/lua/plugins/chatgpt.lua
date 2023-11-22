return {
  {
    "jackMort/ChatGPT.nvim",
    keys = {
      { "<leader>cc", "<cmd>ChatGPT<CR>", "ChatGpt" },
      { "<leader>ca", "<cmd>ChatGPTActAs<CR>", "Act As" },
      { "<leader>ce", "<cmd>ChatGPTEditWithInstructions<CR>", "Edit" },
      { "<leader>cr", "<cmd>ChatGPTRun<CR>", "Run" },
      { "<leader>cR", "<cmd>ChatGPTRunCustomCodeAction<CR>", "Run Custom Code Action" },
    },
    opt = {
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
        model = "gpt-3.5-turbo-16k",
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
