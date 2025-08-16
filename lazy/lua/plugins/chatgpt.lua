return {
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>o", "", desc = "ChatGpt" },
      { "<leader>oc", "<cmd>ChatGPT<CR>", desc = "ChatGpt" },
      { "<leader>oa", "<cmd>ChatGPTActAs<CR>", desc = "Act As" },
      { "<leader>oe", "<cmd>ChatGPTEditWithInstructions<CR>", desc = "Edit" },
      { "<leader>or", "<cmd>ChatGPTRun<CR>", "Run" },
      { "<leader>oR", "<cmd>ChatGPTRunCustomCodeAction<CR>", desc = "Run Custom Code Action" },
      { "<leader>oE", "<cmd>ChatGPTRunCustomCodeAction<CR>", mode = { "v" }, desc = "Run Custom Code Action" },
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
        model = "gpt-5",
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
}
