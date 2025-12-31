return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    -- ensure that other plugins that use telescope can function properly
    cmd = "Telescope",
    opts = {
      defaults = {
        initial_mode = "insert",
        mappings = {
          i = {
            ["<C-e>"] = "move_selection_next",
            ["<C-u>"] = "move_selection_previous",
            ["<C-n>"] = "cycle_history_next",
            ["<C-p>"] = "cycle_history_prev",
            ["<C-c>"] = "close",
            ["<C-f>"] = "preview_scrolling_up",
            ["<C-b>"] = "preview_scrolling_down",
          },
        },
      },
      pickers = {
        find_files = {
          winblend = 20,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
      telescope.load_extension("undo")
    end,
    keys = {
      { "<leader>tf", "<Cmd>Telescope find_files<CR>", desc = "find file", silent = true },
      {
        "<leader>tF",
        function()
          require("telescope.builtin").live_grep({
            layout_strategy = "vertical",
          })
        end,
        desc = "live grep",
        silent = true,
      },
      { "<leader>tb", "<Cmd>Telescope buffers<CR>", desc = "manage buffers", silent = true },
      { "<leader>uu", "<Cmd>Telescope undo<CR>", desc = "Telescope undotree", silent = true },
      {
        "<leader>ps",
        function()
          require("telescope.builtin").grep_string({
            search = vim.fn.input("Grep > "),
            use_regex = true,
            layout_strategy = "vertical",
          })
        end,
      },
      {
        "<leader>o",
        function()
          require("telescope.builtin").live_grep({
            grep_open_files = true,
            layout_strategy = "vertical",
          })
        end,
        desc = "Search in open files",
      },
    },
  },
  {
    "chentoast/marks.nvim",
    lazy = true,
    event = "User IceLoad",
    config = function()
      require("marks").setup({
        default_mappings = true,
      })
    end,
  },
  {
    "Bekaboo/dropbar.nvim",
    -- optional, but required for fuzzy finder support
    lazy = true,
    event = "User IceLoad",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    config = function()
      local dropbar_api = require("dropbar.api")
      vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
      vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
      vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
    end,
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
  {
    "ThePrimeagen/harpoon",
    lazy = true,
    branch = "harpoon2",
    event = "User IceLoad",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")

      -- REQUIRED
      harpoon:setup()
      -- REQUIRED
      -- basic telescope configuration
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers")
          .new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
              results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
          })
          :find()
      end

      vim.keymap.set("n", "<leader>e", function()
        toggle_telescope(harpoon:list())
      end, { desc = "Open harpoon window" })

      vim.keymap.set("n", "<leader>a", function()
        harpoon:list():add()
      end)

      vim.keymap.set("n", "<C-h>", function()
        harpoon:list():select(1)
      end)
      vim.keymap.set("n", "<C-t>", function()
        harpoon:list():select(2)
      end)
      vim.keymap.set("n", "<C-n>", function()
        harpoon:list():select(3)
      end)
      vim.keymap.set("n", "<C-s>", function()
        harpoon:list():select(4)
      end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "<C-S-P>", function()
        harpoon:list():prev()
      end)
      vim.keymap.set("n", "<C-S-N>", function()
        harpoon:list():next()
      end)
    end,
  },
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
        desc = "Open the file manager",
      },
    },
    opts = {},
  },
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    opts = {},
    keys = {
      { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
    },
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      labels = "arstdhneioqwfpgjluyzxcvbkm",
      modes = {
        char = {
          enable = false,
          label = { exclude = "nueiwardc" },
          keys = { ";", "," },
        },
      },
    },
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
  },
}
