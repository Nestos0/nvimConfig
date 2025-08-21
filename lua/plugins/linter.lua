return {
  "mfussenegger/nvim-lint",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      c = { "cpplint" },
      cpp = { "cpplint" },
    }

    lint.linters.cpplint.args = {
      "--filter=-build/class,-build/namespaces,-build/include_order,-whitespace/indent,-whitespace/parens,-whitespace/braces,-readability/namespace,-readability/function,-readability/nolint,-legal/copyright",
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
