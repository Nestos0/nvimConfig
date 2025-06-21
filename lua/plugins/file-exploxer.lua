M = {
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    opts = {},
    keys = {
      { "-", "<CMD>Oil<CR>", desc = "Open parent directory" }
    },
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
  {
    "s1n7ax/nvim-window-picker",
    lazy = true,
    event = "User IceLoad",
    version = "2.*",
    opts = {
      filter_rules = {
        include_current_win = false,
        autoselect_one = true,
        -- filter using buffer options
        bo = {
          -- if the file type is one of following, the window will be ignored
          filetype = { "neo-tree", "neo-tree-popup", "notify" },
          -- if the buffer type is one of following, the window will be ignored
          buftype = { "terminal", "quickfix" },
        },
      },
    },
  },
  { "MunifTanjim/nui.nvim", lazy = true },
  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = true,
    event = "User IceLoad",
    branch = "v3.x",
    keys = {
      { "<M-m>", "<cmd>Neotree toggle<CR>", desc = "Toggle Neotree" },
    },
    dependencies = {
      "s1n7ax/nvim-window-picker",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    opts = {
      source_selector = {
        winbar = true,
        statusline = false,
      },
      window = {
        mappings = {
          ["e"] = "noop",
          ["ge"] = "toggle_auto_expand_width",
        },
      },

      buffers = {
        window = {
          mappings = {
            ["i"] = "noop",
            ["gi"] = "show_file_details",
          },
        },
      },
    },
  },
  {
    "mikavilpas/yazi.nvim",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      {
        -- 👇 choose your own keymapping
        "<leader>-",
        function()
          require("yazi").yazi()
        end,
        desc = "Open the file manager" ,
      },
    },
    opts = {},
  },
}

return M
