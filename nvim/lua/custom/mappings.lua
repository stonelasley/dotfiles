local M = {}

M.general = {
  i = {
    -- Break undo
    [","] = { ",<c-g>u" },
    ["."] = { ".<c-g>u" },
    [";"] = { ";<c-g>u" },
  }
}

M.telescope = {
  n = {
    ["<C-p>"] = { "<cmd> Telescope find_files <CR>", "find files" },
    ["<C-f>"] = { "<cmd> Telescope live_grep<CR>", "find files" },
  }
}

M.vim_tmux_navigator = {
  n = {
    ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "Tmux Navigate Up" },
    ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "Tmux Navigate Down" },
    ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "Tmux Navigate Right" },
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "Tmux Navigate Left" },
  }
}

M.bufferline = {
  n = {
    ["<S-l>"] = { "<cmd> BufferLineCycleNext <CR>", "  cycle next buffer" },
    ["<S-h>"] = { "<cmd> BufferLineCyclePrev <CR>", "  cycle prev buffer" },
    ["<S-x>"] = {
      function()
        require("core.utils").close_buffer()
      end,
      "   close buffer",
    },
  }
}

M.lspconfig = {
  n = {
    ["gt"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "   lsp definition type",
    },
    ["<leader>lr"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "   lsp definition type",
    },
    ["<F2>"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "   lsp definition type",
    },
    ["<leader>la"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "   lsp code action",
    },
    ["<leader>lf"] = {
      function()
        vim.lsp.buf.formatting()
      end,
      "   lsp format",
    },
    ["<F12>"] = {
      function()
        vim.lsp.buf.formatting()
      end,
      "   lsp format",
    },
    ["<leader>lw"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "   add workspace folder",
    },
    ["<leader>lx"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "   add workspace folder",
    },
    ["<leader>ll"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "   list workspace folders",
    },
  }

}

M.disabled = {
  n = {
    ["<C-s>"] = "",
    ["<C-c>"] = "",
    ["<leader>n"] = "",
    ["<leader>rn"] = "",
    ["<leader>ra"] = "",
    ["<leader>ca"] = "",
    ["<leader>fm"] = "",
    ["<leader>D"] = "",
    ["<leader>wa"] = "",
    ["<leader>wr"] = "",
    ["<leader>wl"] = "",
  },
  i = {}
}

return M
