local present, lsp_lines = pcall(require, "lsp_lines")

if present then
  lsp_lines.setup()
  vim.diagnostic.config {
    virtual_text = false,
  }
end

