local ls = require('luasnip')
local s = ls.s
local i = ls.insert_node
local types = require('luasnip.util.types')
local rep = require('luasnip.extras').rep
local fmt = require('luasnip.extras.fmt').fmt

ls.snippets = {
  all = {
    ls.parser.parse_snippet('expand', '-- first expansion'),
  },
  lua = {
    ls.parser.parse_snippet('lf', 'local $1 = function($2)\n $0 \nend '),
  },
  vue = {
    ls.parser.parse_snippet('import', 'import { $1 } from '~/types/something/typename'$0),
  },
}
-- <c-e> expansion
-- this will expand the current item or jump to the next item within the snippet.
vim.keymap.set({ 'i', 's' }, '<c-e>', function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })
