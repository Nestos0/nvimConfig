return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    event = { "BufReadPre", "BufNewFile", "BufReadPost" },
    build = ":TSUpdate",
    dependencies = {
      "posva/vim-vue",
      "windwp/nvim-ts-autotag",
    },
    init = function()
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

      parser_config.c3 = {
        install_info = {
          url = "https://github.com/CM-IV/tree-sitter-c3",
          files = { "src/parser.c", "src/scanner.c"  },
          branch = "main",
        },
        filetype = "c3",
      }
    end,
    opts = {
      ensure_installed = { "c", "c3", "lua", "vim", "vimdoc", "javascript", "html", "ruby", "go", "vue", "css", "scss", "zig", "typst" },
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
      highlight = { enable = true },
      indent = { enable = true },
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
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
    event = "VeryLazy",
    enabled = true,
    config = function()
      -- When in diff mode, we want to use the default
      -- vim text objects c & C instead of the treesitter ones.
      local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
      local configs = require("nvim-treesitter.configs")
      for name, fn in pairs(move) do
        if name:find("goto") == 1 then
          move[name] = function(q, ...)
            if vim.wo.diff then
              local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
              for key, query in pairs(config or {}) do
                if q == query and key:find("[%]%[][cC]") then
                  vim.cmd("normal! " .. key)
                  return
                end
              end
            end
            return fn(q, ...)
          end
        end
      end
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
