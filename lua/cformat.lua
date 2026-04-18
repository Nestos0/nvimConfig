vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "yacc" },
  callback = function()
    vim.opt.expandtab = false
    vim.opt.tabstop = 8
    vim.opt.shiftwidth = 8
    vim.opt.softtabstop = 8
    vim.opt.textwidth = 100
    vim.opt.formatoptions = "croql"
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
    vim.opt.foldenable = true
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
      "(0",
    }
  end,
})

vim.filetype.add({
  extension = {
    h = 'c',
  },
})
