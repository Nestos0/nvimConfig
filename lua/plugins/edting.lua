return {
  {
    "Nestos0/multiple-cursors.nvim",
    version = "*", -- Use the latest tagged version
    lazy = false,
    opts = {
      custom_key_maps = {
        { "u", "NormalMotionUp" },
        { "<Up>", "NormalMotionUp" },
        { { "e", "<Down>" }, "NormalMotionDown" },
        { { "n", "<Left>" }, "NormalMotionLeft" },
        { { "i", "<Right>", "<Space>" }, "NormalMotionRight" },
        { { "k", "<S-Right>", "<C-Right>" }, "NormalMotionWordNext" },
        { "k", "NormalMotionWordNextBare" },
        { "l", "NormalMotionWordEnd" },
        { "l", "NormalMotionWordEndBare" },
        { "w", "NormalInsertBefore" }
      },
    },
    keys = {
      { "<M-e>", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n", "x" }, desc = "Add cursor and move down" },
      { "<M-u>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "x" }, desc = "Add cursor and move up" },

      { "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "i", "x" }, desc = "Add cursor and move up" },
      { "<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n", "i", "x" }, desc = "Add cursor and move down" },

      {
        "<C-LeftMouse>",
        "<Cmd>MultipleCursorsMouseAddDelete<CR>",
        mode = { "n", "i" },
        desc = "Add or remove cursor on mouse click",
      },
      {
        "<C-Return>",
        "<Cmd>MultipleCursorsAddDelete<CR>",
        mode = { "n" },
        desc = "Add a locked cursor or remove an existing cursor",
      },

      {
        "<Leader>m",
        "<Cmd>MultipleCursorsAddVisualArea<CR>",
        mode = { "x" },
        desc = "Add cursors to the lines of the visual area",
      },

      { "<Leader>a", "<Cmd>MultipleCursorsAddMatches<CR>", mode = { "n", "x" }, desc = "Add cursors to cword" },
      {
        "<Leader>A",
        "<Cmd>MultipleCursorsAddMatchesV<CR>",
        mode = { "n", "x" },
        desc = "Add cursors to cword in previous area",
      },

      {
        "<Leader>d",
        "<Cmd>MultipleCursorsAddJumpNextMatch<CR>",
        mode = { "n", "x" },
        desc = "Add cursor and jump to next cword",
      },
      { "<Leader>D", "<Cmd>MultipleCursorsJumpNextMatch<CR>", mode = { "n", "x" }, desc = "Jump to next cword" },

      { "<Leader>l", "<Cmd>MultipleCursorsLock<CR>", mode = { "n", "x" }, desc = "Lock virtual cursors" },
    },
  },
  {
    "pysan3/fcitx5.nvim",
    -- 仅在 Linux 且存在 fcitx5-remote 时加载
    cond = vim.fn.executable("fcitx5-remote") == 1,
    -- 建议在 ModeChanged 时按需加载，性能最优
    event = "ModeChanged",
    opts = {
      -- 这里的 imname 可以通过在终端运行 `fcitx5-remote -n` 获取
      -- 通常中文状态是 "pinyin" 或 "rime"，英文是 "keyboard-us"
      imname = {
        norm = nil, -- 进入 Normal 模式时恢复的状态（nil 表示不强制恢复，由插件逻辑处理）
        ins = nil, -- 进入 Insert 模式时恢复的状态
      },
      remember_prior = true, -- 记住每个 buffer 之前的输入状态
      define_autocmd = true, -- 自动定义 autocmd 切换模式
    },
  },
  {
    "jakemason/ouroboros",
    dependencies = { { "nvim-lua/plenary.nvim" } },
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
  "moll/vim-bbye",
  {
    "Nestos0/ultimate-autopair.nvim",
    opts = {
      fastwarp = {
        enable = true,
        map = "<A-k>",
        rmap = "<A-K>",
        cmap = "<A-k>",
        rcmap = "<A-K>",
      },
    },
  },
  {
    "abecodes/tabout.nvim",
    lazy = false,
    config = function()
      require("tabout").setup({
        tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true, -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
        default_shift_tab = "<C-d>", -- reverse shift default action,
        enable_backwards = true, -- well ...
        completion = false, -- if the tabkey is used in a completion pum
        tabouts = {
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = "`", close = "`" },
          { open = "(", close = ")" },
          { open = "[", close = "]" },
          { open = "{", close = "}" },
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {}, -- tabout will ignore these filetypes
      })
    end,
    dependencies = { -- These are optional
      "nvim-treesitter/nvim-treesitter",
    },
    opt = true, -- Set this to true if the plugin is optional
    event = "InsertCharPre", -- Set the event to 'InsertCharPre' for better compatibility
    priority = 1000,
  },
  {
    "kevinhwang91/nvim-fundo",
    lazy = true,
    event = "User IceLoad",
    requires = "kevinhwang91/promise-async",
    opts = {},
  },
  {
    "smjonas/inc-rename.nvim",
    opts = {},
    config = function(_, opts)
      vim.keymap.set("n", "<leader>rn", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, { expr = true })
      require("inc_rename").setup(opts)
    end,
  },
  {
    "numToStr/Comment.nvim",
    lazy = true,
    event = "User IceLoad",
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
    "echasnovski/mini.surround",
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local opts = {
        mappings = {
          add = "gsa", -- Add surrounding in Normal and Visual modes
          delete = "gsd", -- Delete surrounding
          find = "gsf", -- Find surrounding (to the right)
          find_left = "gsF", -- Find surrounding (to the left)
          highlight = "gsh", -- Highlight surrounding
          replace = "gsr", -- Replace surrounding
          update_n_lines = "gsn", -- Update `n_lines`
        },
      }
      local mappings = {
        { opts.mappings.add, desc = "Add Surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete Surrounding" },
        { opts.mappings.find, desc = "Find Right Surrounding" },
        { opts.mappings.find_left, desc = "Find Left Surrounding" },
        { opts.mappings.highlight, desc = "Highlight Surrounding" },
        { opts.mappings.replace, desc = "Replace Surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
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
        "gy",
        "<Plug>(YankyYank)",
        mode = { "n", "x" },
        desc = "Yank text",
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
    "Mathijs-Bakker/godotdev.nvim",
    dependencies = { "nvim-dap", "nvim-dap-ui", "nvim-treesitter" },
    opts = {},
  },
}
