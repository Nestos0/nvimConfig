local M = {}

local next_key = nil

-- local listener = vim.on_key(function(key)
--     vim.notify(key)
-- end)

local function setup_visual_mapping()
  vim.keymap.set("x", "i", "i", { noremap = true })
  next_key = vim.fn.getcharstr()

  if next_key == "i" then
    vim.api.nvim_input("i")
    vim.schedule(function()
      vim.keymap.set("x", "i", "l", { noremap = true })
      vim.api.nvim_input("i")
    end)
  else
    vim.keymap.set("x", "i", "l", { noremap = true })
    vim.schedule(function()
      vim.api.nvim_input(next_key)
    end)
  end
end

-- 恢复原始映射
local function restore_mapping()
  vim.keymap.set("x", "i", "i", { noremap = true })
end

-- 初始化插件
function M.setup()
  -- 监听模式变化
  vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "*:[v\x16]*",
    callback = setup_visual_mapping,
  })

  vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "[v\x16]*:*",
    callback = restore_mapping,
  })
end

return M
