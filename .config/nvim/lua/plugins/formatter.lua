return {
  'stevearc/conform.nvim',
  opts = {},
  config = function()
    local conform = require 'conform'
    conform.setup {
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        javascript = { 'prettierd' },
        typescript = { 'prettierd' },
      },
      formatters = {
        prettierd = {
          env = {
            PRETTIERD_DEFAULT_CONFIG = vim.fn.expand('~/.config/ts/.prettierrc.json'),
          }
        }
      }
    }

    local format = function()
      conform.format()
      require('lint').try_lint()
    end

    vim.keymap.set('n', '<leader>f', format, { noremap = true, silent = true, desc = "format current buffer" })
  end,
}
