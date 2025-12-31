return {
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
  {
    "xemptuous/sqlua.nvim",
    lazy = true,
    cmd = "SQLua",
    config = function()
      require("sqlua").setup()
    end,
  },
  { "MunifTanjim/nui.nvim", lazy = true },
  "nvim-lua/plenary.nvim",
  {
    "vhyrro/luarocks.nvim",
    lazy = true,
    cmd = "Luarocks",
    priority = 9001, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    opts = {
      rocks = { "promise-async", "magick" }, -- specifies a list of rocks to install
      -- luarocks_build_args = { "--with-lua=/my/path" }, -- extra options to pass to luarocks's configuration script
    },
  },
}
