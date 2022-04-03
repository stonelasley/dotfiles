local ls = require('luasnip')
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require('luasnip.extras.fmt').fmt
local util = require('utils')

return {
  s(
    'import',
    fmt([[import {{ {} }} from '~/{}']], {
      i(1),
      i(2),
    })
  ),
  s(
    'impcomponent',
    fmt([[import {} from '~/components/{}.vue']], {
      f(function(import_name)
        local parts = vim.split(import_name[1][1], '/', true)
        local file = vim.split(parts[1], '.', true)
        util.dump(file)
        return parts[#parts] or ''
      end, { 1 }),
      i(1),
    })
  ),
}
