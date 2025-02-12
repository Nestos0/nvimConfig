return {

  -- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      vim.opt.termguicolors = true
      require("colorizer").setup({
        "css",
        "javascript",
        html = { mode = "background" },
      }, {
        mode = "foreground",
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
      })
    end,
  },
  {
    "max397574/colortils.nvim",
    cmd = "Colortils",
    config = function()
      require("colortils").setup({
        -- Register in which color codes will be copied
        register = "+",
        -- Preview for colors, if it contains `%s` this will be replaced with a hex color code of the color
        color_preview = "█ %s",
        -- The default in which colors should be saved
        -- This can be hex, hsl or rgb
        default_format = "hex",
        -- String: default color if no color is found
        default_color = "#000000",
        -- Border for the float
        border = "rounded",
        -- Some mappings which are used inside the tools
        mappings = {
          -- increment values
          increment = "i",
          -- decrement values
          decrement = "n",
          -- increment values with bigger steps
          increment_big = "I",
          -- decrement values with bigger steps
          decrement_big = "N",
          -- set values to the minimum
          min_value = "0",
          -- set values to the maximum
          max_value = "$",
          -- save the current color in the register specified above with the format specified above
          set_register_default_format = "<cr>",
          -- save the current color in the register specified above with a format you can choose
          set_register_choose_format = "g<cr>",
          -- replace the color under the cursor with the current color in the format specified above
          replace_default_format = "<m-cr>",
          -- replace the color under the cursor with the current color in a format you can choose
          replace_choose_format = "g<m-cr>",
          -- export the current color to a different tool
          export = "E",
          -- set the value to a certain number (done by just entering numbers)
          set_value = "c",
          -- toggle transparency
          transparency = "T",
          -- choose the background (for transparent colors)
          choose_background = "B",
          -- quit window
          quit_window = { "q", "<esc>" },
        },
      })
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        ---Add a space b/w comment and the line
        padding = true,
        ---Whether the cursor should stay at its position
        sticky = true,
        ---Lines to be ignored while (un)comment
        ignore = "^$",
        ---LHS of toggle mappings in NORMAL mode
        toggler = {
          ---Line-comment toggle keymap
          line = "gcc",
          ---Block-comment toggle keymap
          block = "gbc",
        },
        ---LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
          ---Line-comment keymap
          line = "gc",
          ---Block-comment keymap
          block = "gb",
        },
        ---LHS of extra mappings
        extra = {
          ---Add comment on the line above
          above = "gcO",
          ---Add comment on the line below
          below = "gco",
          ---Add comment at the end of line
          eol = "gcA",
        },
        ---Enable keybindings
        ---NOTE: If given `false` then the plugin won't create any mappings
        mappings = {
          ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
          basic = true,
          ---Extra mapping; `gco`, `gcO`, `gcA`
          extra = true,
        },
        ---Function to call before (un)comment
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),

        ---Function to call after (un)comment
        post_hook = function(ctx)
          if ctx.range.srow == ctx.range.erow then
          -- do something with the current line
          else
            -- do something with lines range
          end
        end,
      })
    end,
  },
  {
    {
      "folke/noice.nvim",
      event = "VeryLazy",
      opts = {
        routes = {
          {
            filter = {
              event = "msg_show",
              any = {
                { find = "Agent service not initialized" },
              },
            },
            opts = { skip = true },
          },
        },
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      },
  -- stylua: ignore
  keys = {
    { "<leader>sn", "", desc = "+noice"},
    { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
    { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
    { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
    { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
    { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    { "<leader>snt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
    { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
    { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
  },
      config = function(_, opts)
        -- HACK: noice shows messages from before it was enabled,
        -- but this is not ideal when Lazy is installing plugins,
        -- so clear the messages in this case.
        if vim.o.filetype == "lazy" then
          vim.cmd([[messages clear]])
        end
        require("noice").setup(opts)
      end,
    },
  },
  {
    "pteroctopus/faster.nvim",
    opts = {
      behaviours = {
        bigfile = {
          on = false,
        },
        fastmacro = {
          -- Behaviour can be turned on or off. To turn on set to true, otherwise
          -- set to false
          on = true,
          -- Table which contains names of features that will be disabled when
          -- macro is executed. Feature names can be seen in features table below.
          -- features_disabled can also be set to "all" and then all features that
          -- are on (on=true) are going to be disabled for this behaviour.
          -- Specificaly: lualine plugin is disabled when macros are executed because
          -- if a recursive macro opens a buffer on every iteration this error will
          -- happen after 300-400 hundred iterations:
          -- `E5108: Error executing lua Vim:E903: Process failed to start: too many open files: "/usr/bin/git"`
          features_disabled = { "lualine" },
        },
      },
    },
  },
  {
    "chrishrb/gx.nvim",
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    cmd = { "Browse" },
    init = function()
      vim.g.netrw_nogx = 1 -- disable netrw gx
    end,
    dependencies = { "nvim-lua/plenary.nvim" }, -- Required for Neovim < 0.10.0
    config = true, -- default settings
    submodules = false, -- not needed, submodules are required only for tests
  },
  {
    "gbprod/yanky.nvim",
    dependencies = {
      { "kkharji/sqlite.lua" },
    },
    opts = {
      ring = { storage = "sqlite" },
    },
    keys = {
      {
        "<leader>p",
        function()
          vim.cmd([[YankyRingHistory]])
        end,
        desc = "Open Yank History",
      },
      {
        "y",
        "<Plug>(YankyYank)",
        mode = { "n", "x" },
        desc = "Yank text",
      },
      {
        "p",
        "<Plug>(YankyPutAfter)",
        mode = { "n", "x" },
        desc = "Put yanked text after cursor",
      },
      {
        "P",
        "<Plug>(YankyPutBefore)",
        mode = { "n", "x" },
        desc = "Put yanked text before cursor",
      },
      {
        "gp",
        "<Plug>(YankyGPutAfter)",
        mode = { "n", "x" },
        desc = "Put yanked text after selection",
      },
      {
        "gP",
        "<Plug>(YankyGPutBefore)",
        mode = { "n", "x" },
        desc = "Put yanked text before selection",
      },
      {
        "<c-p>",
        "<Plug>(YankyPreviousEntry)",
        desc = "Select previous entry through yank history",
      },
      {
        "<c-n>",
        "<Plug>(YankyNextEntry)",
        desc = "Select next entry through yank history",
      },
      {
        "]p",
        "<Plug>(YankyPutIndentAfterLinewise)",
        desc = "Put indented after cursor (linewise)",
      },
      {
        "[p",
        "<Plug>(YankyPutIndentBeforeLinewise)",
        desc = "Put indented before cursor (linewise)",
      },
      {
        "]P",
        "<Plug>(YankyPutIndentAfterLinewise)",
        desc = "Put indented after cursor (linewise)",
      },
      {
        "[P",
        "<Plug>(YankyPutIndentBeforeLinewise)",
        desc = "Put indented before cursor (linewise)",
      },
      {
        ">p",
        "<Plug>(YankyPutIndentAfterShiftRight)",
        desc = "Put and indent right",
      },
      {
        "<p",
        "<Plug>(YankyPutIndentAfterShiftLeft)",
        desc = "Put and indent left",
      },
      {
        ">P",
        "<Plug>(YankyPutIndentBeforeShiftRight)",
        desc = "Put before and indent right",
      },
      {
        "<P",
        "<Plug>(YankyPutIndentBeforeShiftLeft)",
        desc = "Put before and indent left",
      },
      {
        "=p",
        "<Plug>(YankyPutAfterFilter)",
        desc = "Put after applying a filter",
      },
      {
        "=P",
        "<Plug>(YankyPutBeforeFilter)",
        desc = "Put before applying a filter",
      },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
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
