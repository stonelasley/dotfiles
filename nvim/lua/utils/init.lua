local M = {}

local scopes = {
  o = vim.o,
  b = vim.bo,
  w = vim.wo,
}

function M.dump(...)
  print(vim.inspect(...))
end

function M.is_table(t)
  return type(t) == "table"
end

function M.is_string(t)
  return type(t) == "string"
end

function M.highlight(group, color)
  local style = color.style and "gui=" .. color.style or "gui=NONE"
  local fg = color.fg and "guifg=" .. color.fg or "guifg=NONE"
  local bg = color.bg and "guibg=" .. color.bg or "guibg=NONE"
  local underln = color.underline and "gui=underline cterm=underline" or ""
  local sp = color.sp and "guisp=" .. color.sp or ""
  vim.api.nvim_command("highlight " .. group .. " " .. style .. " " .. fg .. " " .. bg .. " " .. sp .. " " .. underln)
end

function M.clear_registers()
  local registers = vim.split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ01234567890/-"*+', "")
  for _, r in ipairs(registers) do
    vim.fn.setreg(r, "")
  end
end

function M.opt(scope, key, value)
  if M.is_table(scope) then
    for _, scopeKey in ipairs(scope) do
      M.opt(scopeKey, key, value)
    end
  end
  if type(scope) == "string" then
    scopes[scope][key] = value
    if scope ~= "o" then
      scopes["o"][key] = value
    end
  end
end

function M.buf_opt(bufnr, ...)
  vim.api.nvim_buf_set_option(bufnr, ...)
end

function M.t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.merge_table(target, source)
  local result = target
  if source ~= nil then
    result = vim.tbl_extend("force", target, source)
  end
  return result
end

return M
