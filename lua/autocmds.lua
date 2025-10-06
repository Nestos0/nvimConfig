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

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function(args)
    if vim.bo[args.buf].filetype ~= "neo-tree" then
      vim.defer_fn(function()
        if vim.api.nvim_buf_is_valid(args.buf) then
          -- 检查当前 buffer 是否已经有 Treesitter 高亮
          vim.cmd("TSEnable highlight")
        end
      end, 50)
    end
  end,
})

vim.api.nvim_create_augroup("IrreplaceableWindows", { clear = true })

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = "IrreplaceableWindows",
  pattern = "*",
  callback = function()
    local filetypes = { "OverseerList", "neo-tree" }
    local buftypes = { "nofile", "terminal" }
    if vim.tbl_contains(buftypes, vim.bo.buftype) and vim.tbl_contains(filetypes, vim.bo.filetype) then
      vim.cmd("set winfixbuf")
    end
  end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.lsp.inlay_hint.enable(false)
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.lsp.inlay_hint.enable(true)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "text", "markdown" },
  callback = function()
    vim.wo.list = false -- 禁用当前窗口的 list（制表符/空格可视化）
    vim.schedule(function()
          if Snacks and Snacks.indent and Snacks.indent.disable then
            Snacks.indent.disable()
          end
        end)
      end,
})
-- vim.api.nvim_create_autocmd("BufReadPost", {
--   group = list_disable_group,
--   pattern = { "*.org" },
--   callback = function()
--     vim.wo.list = false
--   end,
-- })
