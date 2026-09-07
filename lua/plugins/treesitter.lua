return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    branch = "main",
    event = { "BufReadPre", "BufNewFile", "BufReadPost" },
    build = ":TSUpdate",
    dependencies = {
      "posva/vim-vue",
      "windwp/nvim-ts-autotag",
    },
    main = "nvim-treesitter",
    init = function()
      local ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "javascript",
        "html",
        "ruby",
        "go",
        "vue",
        "css",
        "scss",
        "zig",
        "typst",
      }
      local already_installed = require("nvim-treesitter.config").get_installed()
      local parsersToInstall = vim
        .iter(ensure_installed)
        :filter(function(parser)
          return not vim.tbl_contains(already_installed, parser)
        end)
        :totable()
      require("nvim-treesitter").install(parsersToInstall)
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          -- Enable treesitter highlighting and disable regex syntax
          pcall(vim.treesitter.start)
          
          local disable = {
            awk = true,
          }

          -- Enable treesitter-based indentation
          if not disable[args.match] then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
      -- ...
    end,
    opts = {
      autotag = {
        enable = true,
        filetype = { "html", "vue" },
      },
      context_commentstring = {
        disable = {},
        enable = true,
        module_path = "ts_context_commentstring.internal",
      },
      sync_install = true,
      endwise = {
        enable = true,
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
            ["]a"] = "@parameter.inner",
          },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
            ["[a"] = "@parameter.inner",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[C"] = "@class.outer",
            ["[A"] = "@parameter.inner",
          },
        },
      },
    },
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
  },
  {
    "windwp/nvim-ts-autotag",
    -- lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    ft = { "html", "vue", "xml" },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-ts-autotag").setup({
        opts = {
          -- Defaults
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = true, -- Auto close on trailing </
        },
        -- Also override individual filetype configs, these take priority.
        -- Empty by default, useful if one of the "opts" global settings
        -- doesn't work well in a specific filetype
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
    opts = {
      separator = nil, -- 无分隔线
      max_lines = 5, -- 最多显示 5 行上下文
      multiwindow = true, -- 支持多窗口
      min_window_height = 15, -- 窗口太小（<15 行）时禁用
    },
    config = function(_, opts)
      require("treesitter-context").setup(opts)

      -- 高亮设置（背景同 CursorLine，底部下划线）
      vim.api.nvim_set_hl(0, "TreesitterContext", { link = "CursorLine" })
      vim.api.nvim_set_hl(0, "TreesitterContextBottom", {
        underline = true,
        sp = "#b4befe", -- 可根据你的主题调整颜色（这里是 Catppuccin/Tokyonight 风格的 lavender）
      })
    end,
  },
}
