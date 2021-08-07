local utils = require('utils')
local M = {}

function M.set_buf_keymaps(ls, bufnr)

  utils.buf_opt(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  utils.buf_map(bufnr, 'n', '<C-]>', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  utils.buf_map(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  utils.buf_map(bufnr, 'n', 'gd', "<cmd>lua require('telescope.builtin').lsp_definitions(require('telescope.themes').get_cursor({}))<CR>", opts)
  utils.buf_map(bufnr, 'n', 'gr', "<cmd>lua require('telescope.builtin').lsp_references(require('telescope.themes').get_cursor({}))<CR>", opts)
  utils.buf_map(bufnr, 'n', 'gR', "<cmd>Trouble lsp_references<CR>", opts)
  utils.buf_map(bufnr, 'n', 'gi', "<cmd>lua require('telescope.builtin').lsp_implementation(require('telescope.themes').get_cursor({}))<CR>", opts)
  utils.buf_map(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  utils.buf_map(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  utils.buf_map(bufnr, 'n', '<leader><leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  utils.buf_map(bufnr, 'n', '<leader><leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  utils.buf_map(bufnr, 'n', '<leader><leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  utils.buf_map(bufnr, 'n', '<C-r><C-r>', [[<cmd>lua require('lspsaga.rename').rename()<CR>]], opts)
  utils.buf_map(bufnr, 'n', '<leader><leader>.', "<cmd>lua require('telescope.builtin').lsp_code_actions(require('telescope.themes').get_cursor({}))<CR>", opts)
  utils.buf_map(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  utils.buf_map(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  utils.buf_map(bufnr, 'n', '<leader><leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  utils.buf_map(bufnr, 'n', '<leader><leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- TODO - prettier should be firing but I'm getting completely diffrent
  -- formatting results
  if ls == 'vuels' then
    utils.buf_map(bufnr, "n", "<leader><leader>p", "<plug>(Prettier)<CR>", { silent = true })
  elseif ls == 'tsserver' then
    utils.buf_map(bufnr, "n", "<leader><leader>p", "<plug>(Prettier)<CR>", opts)
  else
    utils.buf_map(bufnr, "n", "<leader><leader>p", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
end

return M
