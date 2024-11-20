return {
  'folke/which-key.nvim',
  config = function()
    local wk = require 'which-key'
    wk.setup()

    wk.add {
      { '<leader>c', group = '[C]ode' },
      { '<leader>d', group = 'Delete to blackhole' },
      { '<leader>g', group = '[G]enerate' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      { '<leader>r', group = '[R]ename' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>w', group = '[W]orkspace' },
      { '<leader>q', group = '[Q]uickfix list' },
      { '<leader>', group = 'VISUAL <leader>' },
    }
  end,
}
