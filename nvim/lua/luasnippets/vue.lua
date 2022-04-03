local ls = require('luasnip')
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require('luasnip.extras.fmt').fmt

ls.filetype_extend('vue', { 'tyescript', 'javascript', 'html' })

return {
  s(
    'prop',
    fmt(
      [[
        @Prop({}) {}: {}
      ]],
      {
        i(1),
        i(2),
        i(3),
      }
    )
  ),
  s(
    'propsync',
    fmt(
      [[
        @PropSync('{}') {}Synced: {}
      ]],
      {
        i(1),
        f(function(name)
          return name or ''
        end, { 1 }),
        i(2),
      }
    )
  ),
}
