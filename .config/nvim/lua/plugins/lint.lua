return {
  'mfussenegger/nvim-lint',
  opts = {},
  config = function()
    require('lint').linters_by_ft = {
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
    }

    local ns = require('lint').get_namespace('eslint_d')
    vim.diagnostic.config({ virtual_text = false }, ns)

    vim.api.nvim_create_autocmd({ "BufRead", "InsertLeave", "BufWritePost" }, {
      callback = function()
        require('lint').try_lint()
      end,
    })
  end,
}
