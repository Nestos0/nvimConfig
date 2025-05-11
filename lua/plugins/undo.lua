return {
  {
    "kevinhwang91/nvim-fundo",
    lazy = true,
    event = "User IceLoad",
    requires = "kevinhwang91/promise-async",
    opts = {},
  },
  {
    "mbbill/undotree",
    lazy = true,
    config = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_TreeNodeShape = "-"
    end,
    keys = {
      { "<leader>uu", "<Cmd>UndotreeToggle<CR>", desc = "undo tree toggle", silent = true },
    },
  },
}
