return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make"
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
      { "<leader>t<C-f>", "<Cmd>Telescope live_grep<CR>", desc = "live grep", silent = true },
      { "<leader>tb", "<Cmd>Telescope buffers<CR>", desc = "manage buffers", silent = true },
      { "<leader>uu", "<Cmd>Telescope undo<CR>", desc = "Telescope undotree", silent = true },
    },
  },
}
