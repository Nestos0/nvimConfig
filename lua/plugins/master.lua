return {
  {
    "xemptuous/sqlua.nvim",
    lazy = true,
    cmd = "SQLua",
    config = function()
      require("sqlua").setup()
    end,
  },
  "nvim-lua/plenary.nvim",
  -- Used to define a keymap
  { "LionC/nest.nvim" },

  -- Theme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  -- Which Key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      plugins = {
        presets = {
          operators = false, -- adds help for operators like d, y, ...
          motions = true, -- adds help for motions
          text_objects = false, -- help for text objects triggered after entering an operator
          windows = true, -- default bindings on <c-w>
          nav = true, -- misc bindings to work with windows
          z = true, -- bindings for folds, spelling and others prefixed with z
          g = true, -- bindings for prefixed with g
        },
      },
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = true })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
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
