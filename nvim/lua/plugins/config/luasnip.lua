local ls = require('luasnip')
local s = ls.s
local i = ls.insert_node
local c = ls.choice_node
local t = ls.text_node
local f = ls.function_node
local types = require('luasnip.util.types')
local rep = require('luasnip.extras').rep
local util = require('utils')

local fmt = require('luasnip.extras.fmt').fmt

ls.config.set_config({
  history = true,
  updateevents = 'TextChanged,TextChangedI',
  enable_autosnippets = true,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        -- virt_text = { { '<--', 'Error' } },
      },
    },
  },
})

ls.snippets = {
  all = {
    ls.parser.parse_snippet('expand', '-- first expansion'),
    --s('req', fmt("local {} = require('{}')", { i(1, 'default'), rep(1) })),
  },
  lua = {
    s('req', fmt("local {} = require('{}')", { i(1, 'anotherDefault'), rep(1) })),
  },
  typescript = {
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
  },
  vue = {
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
  },
}
-- <c-e> expansion
-- this will expand the current item or jump to the next item within the snippet.
-- vim.keymap.set({ 'i', 's' }, '<c-e>', function()
--   if ls.expand_or_jumpable() then
--     ls.expand_or_jump()
--   end
-- end, { silent = true })
--
ls.filetype_extend('vue', { 'tyescript', 'javscript', 'html' })

vim.keymap.set('i', '<c-l>', function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)
