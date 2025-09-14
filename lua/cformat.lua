vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.opt.expandtab = true
    vim.opt.tabstop = 8
    vim.opt.shiftwidth = 2
    vim.opt.softtabstop = 2
    vim.opt.textwidth = 79
    vim.opt.formatoptions = "croql"
    vim.opt_local.cinoptions = {
      ">2s",
      "e-s",
      "n-s",
      "{1s",
      "^-s",
      "Ls",
      ":s",
      "=s",
      "g0",
      "+.5s",
      "p2s",
      "t0",
      "(0"
    }

    vim.cmd("match ErrorMsg /\\%>79v.\\+/")
  end,
})
