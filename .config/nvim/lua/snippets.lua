local ls = require 'luasnip'
local s = ls.snippet
local p = require('luasnip.extras').partial

ls.add_snippets('all', {
  s({ trig = 'migrationdate', name = 'Date for migration', dscr = 'Generate current date for migration file' }, {
    p(os.date, '%Y%m%d%H%M%S'),
  }),
})
