local utils = {}

local scopes = {
  o = vim.o,
  b = vim.bo,
  w = vim.wo
}

function utils.opt(scope, key, value)
  if type(scope) == "table" then
    for _, scopeKey in ipairs(scope) do
      utils.opt(scopeKey, key, value)
    end
  end
  if type(scope) == "string" then
    scopes[scope][key] = value
    if scope ~= 'o' then 
      scopes['o'][key] = value 
    end
  end
end

function utils.map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function utils.t (str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

return utils

