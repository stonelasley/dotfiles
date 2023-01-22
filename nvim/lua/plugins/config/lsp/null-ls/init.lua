local M = {}

local nls = require "null-ls"
local nls_utils = require "null-ls.utils"
local b = nls.builtins

local with_diagnostics_code = function(builtin)
  return builtin.with {
    diagnostics_format = "#{m} [#{c}]",
  }
end

local sources = {
  -- formatting
  b.formatting.prettierd,
  b.formatting.stylua,
  b.formatting.csharpier,
  b.diagnostics.eslint_d,
  b.diagnostics.tsc,
  with_diagnostics_code(b.diagnostics.shellcheck),
  b.diagnostics.zsh,
  b.code_actions.gitsigns.with {
    disabled_filetypes = { "terminal", "Telescope", "TelescopeResult" },
  },
  b.code_actions.eslint_d,
  b.code_actions.gitrebase,
  b.code_actions.shellcheck,
  b.hover.dictionary,
}

function M.setup(opts)
  nls.setup {
    debounce = 150,
    save_after_format = false,
    sources = sources,
    on_attach = opts.on_attach,
    root_dir = nls_utils.root_pattern ".git",
    debug = false,
  }
end

return M
