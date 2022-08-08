local map = require("kartograaf").map
local utils = require "utils"
local M = {}

function M.setup(client, bufnr)
  utils.buf_opt(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  if client.server_capabilities.documentFormattingProvider then
    map {
      n = {
        options = { silent = true },
        buffer = bufnr,
        { "<F12>", "<cmd>lua vim.lsp.buf.format({async = true})<CR>" },
      },
    }
  end
  map {
    n = {
      options = { silent = true },
      buffer = bufnr,
      { "K", "<Cmd>lua vim.lsp.buf.hover()<CR>" },
      { "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>" },
      { "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>" },
      -- { '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>' },
      { "<F2>", "<cmd>Lspsaga rename<CR>" },
      {
        prefix = "<leader><leader>",
        { "wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>" },
        { "wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>" },
        { "wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>" },
        { "e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>" },
        { "q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>" },
        { "p", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>" },
        {
          ".",
          "<cmd>lua require('telescope.builtin').lsp_code_actions(require('telescope.themes').get_cursor({}))<CR>",
        },
      },
      {
        prefix = "g",
        { "D", "<Cmd>lua vim.lsp.buf.declaration()<CR>" },
        { "k", "<cmd>lua vim.lsp.buf.signature_help()<CR>" },
        -- { 'd', "<cmd>lua vim.lsp.buf.definition()<CR>"},
        {
          "d",
          "<cmd>lua require('telescope.builtin').lsp_definitions(require('telescope.themes').get_cursor({}))<CR>",
        },
        {
          "r",
          "<cmd>lua require('telescope.builtin').lsp_references(require('telescope.themes').get_cursor({}))<CR>",
        },
        -- { 'i', '<cmd>lua vim.lsp.buf.implementation()<CR>' }
        {
          "i",
          "<cmd>lua require('telescope.builtin').lsp_implementations(require('telescope.themes').get_cursor({}))<CR>",
        },
        { "R", "<cmd>Trouble lsp_references<CR>" },
      },
      {
        mod = "C",
        { "]", "<cmd>lua vim.lsp.buf.type_definition()<CR>" },
      },
    },
    i = {
      {
        mod = "C",
      },
    },
  }
end
return M
