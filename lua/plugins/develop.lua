return {
  {
    "Rizwanelansyah/simplyfile.nvim",
    config = function()
      require("simplyfile").setup({
        border = {
          left = "rounded",
          main = "double",
          right = "rounded",
        },
        derfault_keymaps = true,
        keymaps = {
          --- your custom keymaps
          --- {dir} have following field
          --- name: name of file/folder
          --- absolute: absolute path of file/folder
          --- icon: the nerd fonts icon
          --- hl: highlight group name for icon
          --- filetype: type of file
          --- is_folder: folder or not
          ["lhs"] = function(dir) --[[ some code ]]
          end,
        },
        preview = {
          image = true, -- for previewing image (for v0.7+ only)
        },
      })
    end,
  },
  {
    "stevearc/overseer.nvim",
    lazy = true,
    event = "User IceLoad",
    opts = {},
  },
  {
    "jakemason/ouroboros",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      extension_preferences_table = {
        -- Higher numbers are a heavier weight and thus preferred.
        -- In the following, .c would prefer to open .h before .hpp
        c = { h = 2, hpp = 1 },
        h = { c = 2, cpp = 1 },
        cpp = { hpp = 2, h = 1 },
        hpp = { cpp = 1, c = 2 },

        -- Ouroboros supports any combination of filetypes you like, simply
        -- add them as desired:
        -- myext = { myextsrc = 2, myextoldsrc = 1},
        -- tpp = {hpp = 2, h = 1},
        -- inl = {cpp = 3, hpp = 2, h = 1},
        -- cu = {cuh = 3, hpp = 2, h = 1},
        -- cuh = {cu = 1}
      },
      -- if this is true and the matching file is already open in a pane, we'll
      -- switch to that pane instead of opening it in the current buffer
      switch_to_open_pane_if_possible = false,
    },
  },
}
