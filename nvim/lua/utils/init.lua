local reload = require('plenary.reload').reload_module

local M = {}

local scopes = {
  o = vim.o,
  b = vim.bo,
  w = vim.wo
}

local dump = function (...)
  print(vim.inspect(...))
end

function M.reload(...)
  reload(...)
end

function M.opt(scope, key, value)
  if type(scope) == "table" then
    for _, scopeKey in ipairs(scope) do
      M.opt(scopeKey, key, value)
    end
  end
  if type(scope) == "string" then
    scopes[scope][key] = value
    if scope ~= 'o' then
      scopes['o'][key] = value
    end
  end
end

function M.buf_map(bufnr, ...)
  vim.api.nvim_buf_set_keymap(bufnr, ...)
end

function M.buf_opt(bufnr, ...)
  vim.api.nvim_buf_set_option(bufnr, ...)
end

function M.map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.t (str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.merge_table(target, source)
  local result = target
  if source ~= nil then
      result = vim.tbl_extend('force', target, source)
  end
  return result
end

return M

