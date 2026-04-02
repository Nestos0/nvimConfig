return {
  {
    "rebelot/heirline.nvim",
    event = "UiEnter",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "lewis6991/gitsigns.nvim",
    },
    config = function()
      require("heirline").setup(require("heirline-config"))
    end,
  },
  "Nestos0/heirline-config",
}
