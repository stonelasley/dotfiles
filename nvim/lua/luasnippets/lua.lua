local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local r = require("luasnip.extras").rep
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

return {
  s("req", fmt("local {} = require('{}')", { i(1, "anotherDefault"), rep(1) })),
  s("print_str", {
    t 'print("',
    i(1, "desrc"),
    t '")',
  }),
  s("print_var1", {
    t 'print("',
    i(1, "desrc"),
    t ': " .. ',
    i(2, "the_variable"),
    t ")",
  }),
  s("print_var2", {
    t 'print("',
    i(1, "the_variable"),
    t ': " .. ',
    r(1),
    t ")",
  }),
  s("print_var3", {
    t 'print("',
    i(1, "desrc"),
    t " | ",
    i(2, "the_variable"),
    t ' : " .. ',
    r(2),
    t ")",
  }),
  s("link_url", {
    t '<a href="',
    f(function(_, snip)
      -- TM_SELECTED_TEXT is a table to account for multiline-selections.
      -- In this case only the first line is inserted.
      return snip.env.TM_SELECTED_TEXT[1] or {}
    end, {}),
    t '">',
    i(1),
    t "</a>",
    i(0),
  }),
  ls.parser.parse_snippet("expand", "-- first expansion"),
}
