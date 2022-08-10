local map = vim.keymap.set
local M = {}

M.n = {
  l = {
    name = "+LSP",
    -- a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
    a = { "<cmd>Lspsaga code_action<CR>", "Code Action" },
    d = { "<cmd>Telescope diagnostics<CR>", "Diagnostics" },
    f = { "<cmd>Lspsaga lsp_finder<CR>", "Finder" },
    i = { "<cmd>LspInfo<CR>", "Lsp Info" },
    r = { "<cmd>Telescope lsp_references<CR>", "References" },
    s = { "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
    t = { "<cmd>TroubleToggle document_diagnostics<CR>", "Trouble" },
    L = { "<cmd>lua vim.lsp.codelens.refresh()<CR>", "Refresh CodeLens" },
    l = { "<cmd>lua vim.lsp.codelens.run()<CR>", "Run CodeLens" },
    D = { "<cmd>lua require('config.lsp').toggle_diagnostics()<CR>", "Toggle Inline Diagnostics" },
    W = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add Workspace Folder" },
    X = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove Workspace Folder" },
    F = {
      "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
      "List Workspace Folder",
    },
    R = { "<cmd>Trouble lsp_references<CR>", "Trouble References" },
  },
}

M.g = {
  name = "+Goto",
  -- d = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
  d = { "<cmd><cmd>Lspsaga preview_definition<CR>", "Definition" },
  D = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
  h = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
  I = { "<cmd>Telescope lsp_implementations<CR>", "Goto Implementation" },
  i = {
    "<cmd>lua require('telescope.builtin').lsp_implementations(require('telescope.themes').get_cursor({}))<CR>",
    "Goto Implementation",
  },
  b = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition" },
  r = {
    "<cmd>lua require('telescope.builtin').lsp_references(require('telescope.themes').get_cursor({}))<CR>",
    "References",
  },
  R = { "<cmd>Trouble lsp_references<CR>", "Trouble References" },

  --b = { "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", "Goto Type Definition" },
}

M.v = {
  l = {
    name = "LSP",
    a = { "<cmd>Lspsaga code_action<CR>", "Code Action" },
  },
}

M.setup = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  map("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
  map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  map("n", "[e", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
  map("n", "]e", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
  map("n", "<F2>", "<cmd>Lspsaga rename<CR>", opts)

  if client.server_capabilities.documentFormattingProvider then
    map("n", "<F12>", "<cmd>lua vim.lsp.buf.format({async = true})<CR>", opts)
  end
end

return M
