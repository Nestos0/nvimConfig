vim.api.nvim_create_autocmd("User", {
  pattern = "IceStart",
  once = true,
  callback = function()
    local function _trigger()
      vim.api.nvim_exec_autocmds("User", { pattern = "IceLoad" })
    end

    if vim.bo.filetype == "snacks_dashboard" then
      vim.api.nvim_create_autocmd("BufEnter", { pattern = "*/*", once = true, callback = _trigger })
    else
      _trigger()
    end
  end,
})

vim.api.nvim_create_autocmd("BufReadPre", {
  pattern = "*",
  once = true,
  callback = function()
    vim.api.nvim_exec_autocmds("User", { pattern = "IceStart" })
  end,
})
