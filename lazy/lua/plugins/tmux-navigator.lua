return {
  {
    "christoomey/vim-tmux-navigator",
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<CR>", "TmuxNavLeft" },
      { "<C-j>", "<cmd>TmuxNavigateDown<CR>", "TmuxNavigateDown " },
      { "<C-k>", "<cmd>TmuxNavigateUp<CR>", "TmuxNavigateUp" },
      { "<C-l>", "<cmd>TmuxNavigateRight<CR>", "TmuxNavigateRight" },
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
