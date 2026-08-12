-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Neovim never rotates lsp.log -- it only warns past 1GB (runtime/lua/vim/lsp/log.lua).
-- At the default WARN level OmniSharp alone grew it to 1GB. Turn it off; re-enable
-- with :lua vim.lsp.set_log_level("debug") when actually debugging a language server.
vim.lsp.set_log_level("off")
