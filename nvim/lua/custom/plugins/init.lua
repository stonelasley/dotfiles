return {
  ["stonelasley/flare.nvim"] = {
    config = function()
      local present, flare = pcall(require, "flare")
      if present then
        flare.setup()
      end
    end
  },
  ["github/copilot.vim"] = {},
  ["christoomey/vim-tmux-navigator"] = {
    config = function()

    end
  },
  ["nvim-treesitter/playground"] = {
    cmd = "TSCaptureUnderCursor",
    config = function()
      require("nvim-treesitter.configs").setup()
    end,
  },
  ["max397574/better-escape.nvim"] = {
    event = "InsertCharPre",
    config = function()
      local present, bs = pcall(require, "better_escape")
      if present then
        bs.setup {
          mapping = { "jk" },
          tiemout = vim.o.timeoutlen,
          clear_empty_lines = false,
          keys = "<Esc>",
        }
      end
    end
  },
}
