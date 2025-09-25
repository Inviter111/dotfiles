return {
  'mfussenegger/nvim-lint',
  opts = {},
  config = function()
    local lint = require('lint')
    lint.linters_by_ft = {
      javascript = { 'eslint' },
      typescript = { 'eslint' },
    }

    local ns = lint.get_namespace('eslint')
    vim.diagnostic.config({ virtual_text = false }, ns)

    lint.linters.eslint.ignore_exitcode = true

    vim.api.nvim_create_autocmd({ "BufRead", "InsertLeave", "BufWritePost" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
