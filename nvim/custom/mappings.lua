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
    ["<leader>"] = {
      l = {
        name = "+LSP",
        ["t"] = {
          function()
            vim.lsp.buf.type_definition()
          end,
          "   lsp definition type",
        },
        ["a"] = {
          function()
            vim.lsp.buf.code_action()
          end,
          "   lsp code action",
        },
        ["f"] = {
          function()
            vim.lsp.buf.formatting()
          end,
          "   lsp format",
        },
        ["w"] = {
          function()
            vim.lsp.buf.add_workspace_folder()
          end,
          "   add workspace folder",
        },
        ["x"] = {
          function()
            vim.lsp.buf.remove_workspace_folder()
          end,
          "   add workspace folder",
        },
        ["l"] = {
          function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end,
          "   list workspace folders",
        },
        ["r"] = {
          function()
            require("nvchad.ui.renamer").open()
          end,
          "   lsp rename",
        },
        ["s"] = {
          function()
            vim.lsp.buf.signature_help()
          end,
          "   lsp signature_help",
        },
      }
    },
    ["gt"] = {
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
    ["<F12>"] = {
      function()
        vim.lsp.buf.formatting()
      end,
      "   lsp format",
    },
  }
}

M.git = {
  n = {
    ["<leader>"] = {
      g = {
        name = "+Git",
        ["c"] = { "<cmd> Telescope git_commits <CR>", "   git commits" },
        ["s"] = { "<cmd> Telescope git_status <CR>", "  git status" },
      }
    }
  }
}

M.packer = {
  n = {
    ["<leader>"] = {
      P = {
        name = "+Packer",
        ["i"] = { "<cmd> PackerInstall<CR>", "Install" },
        ["u"] = { "<cmd> PackerUpdate<CR>", "Update" },
        ["s"] = { "<cmd> PackerStatus<CR>", "Status" },
        ["c"] = { "<cmd> PackerCompile<CR>", "Compile" },
      }
    }
  }
}

M.nvchad = {
  n = {
    ["<leader>"] = {
      N = {
        name = "+Nvim",
        ["u"] = { "<cmd> NvChadUpdate<CR>", "Update NvChad" },
      }
    }
  }
}

M.whichkey = {
  n = {
    ["<leader>"] = {
      w = {
        name = "+WhichKey",
        ["k"] = {
          function()
            vim.cmd "WhichKey"
          end,
          "   which-key all keymaps",
        },
        ["l"] = {
          function()
            local input = vim.fn.input "WhichKey: "
            vim.cmd("WhichKey " .. input)
          end,
          "   which-key query lookup",
        }
      },
    },
  },
}

M.orgmode = {
  n = {
    ["<leader>"] = {
      o = {
        name = "+Orgmode",
        ["a"] = { "<cmd> lua require('orgmode').action('agenda.prompt', { opts = { buffer = false } })<CR>", "Agenda Prompt" },
        ["c"] = { "<cmd> lua require('orgmode').action('capture.prompt', { opts = { buffer = false } })<CR>", "Capture Prompt" },
      }
    }
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
    ["<leader>/"] = "",
    ["<leader>e"] = "",
    ["<leader>ls"] = "",
    ["<leader>cm"] = "",
    ["<leader>gt"] = "",
    ["<leader>x"] = "",
    ["<leader>wK"] = "",
    ["<leader>wk"] = "",
    ["<C-h>"] = "",
    ["<C-j>"] = "",
    ["<C-k>"] = "",
    ["<C-l>"] = "",
  },
  i = {}
}

return M
