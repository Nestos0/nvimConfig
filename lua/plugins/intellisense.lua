return {
  {
    "pmizio/typescript-tools.nvim",
    ft = { "typescript", "javascript", "vue" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      local api = require("typescript-tools.api")
      return {
        on_attach = function(_, bufnr)
          local opts = { buffer = bufnr, remap = false }
          vim.keymap.set("n", "gd", "<cmd>TSToolsGoToSourceDefinition<CR>", opts)
        end,
        handlers = {
          ["textDocument/publishDiagnostics"] = api.filter_diagnostics({ 80001, 80006 }),
        },
        settings = {
          tsserver_file_preferences = {
            disableSuggestions = true,
          },
        },
      }
    end,
  },
  {
    "Nestos0/tailwind-tools.nvim",
    ft = { "vue", "html", "css", "javascript" },
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
    },
    opts = {}, -- your configuration
  },
  "rafamadriz/friendly-snippets",
  {
    "MysticalDevil/inlay-hints.nvim",
    event = "LspAttach",
    -- config = function()
    --   require("inlay-hints").setup()
    -- end,
  },
  {
    "p00f/clangd_extensions.nvim",
    config = function()
      require("clangd_extensions").setup({
        ast = {
          role_icons = {
            type = "",
            declaration = "",
            expression = "",
            specifier = "",
            statement = "",
            ["template argument"] = "",
          },

          kind_icons = {
            Compound = "",
            Recovery = "",
            TranslationUnit = "",
            PackExpansion = "",
            TemplateTypeParm = "",
            TemplateTemplateParm = "",
            TemplateParamObject = "",
          },

          highlights = {
            detail = "Comment",
          },
        },
        memory_usage = {
          border = "none",
        },
        symbol_info = {
          border = "none",
        },
      })
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("lsp_signature").setup({
        bind = true,
        handler_opts = {
          border = "rounded",
        },
        hint_enable = true,
        hint_prefix = " ",
        hint_scheme = "String",
        floating_window = false,
        floating_window_above_cur_line = true,
        fix_pos = false,
        toggle_key = "<M-s>",
        select_signature_key = "<M-n>",
        transparency = 20,
      })
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  { -- optional blink completion source for require statements and module annotations
    "saghen/blink.cmp",
    lazy = true,
    version = "*",
    build = "cargo build --release",
    dependencies = {
      "rafamadriz/friendly-snippets",
      { "Nestos0/colorful-menu.nvim", opts = {} },
      -- add blink.compat to dependencies
      {
        "saghen/blink.compat",
        opts = {},
        lazy = true,
        version = "*",
      },
    },
    event = { "InsertEnter", "CmdlineEnter", "User IceLoad" },
    opts = {
      completion = {

        keyword = { range = "full" },
        trigger = { show_on_trigger_character = true },

        -- Disable auto brackets
        -- NOTE: some LSPs may add auto brackets themselves anyway
        accept = { auto_brackets = { enabled = false } },

        -- Don't select by default, auto insert on selection
        list = { selection = { preselect = false, auto_insert = true } },

        ghost_text = { enabled = true },

        menu = {
          -- Don't automatically show the completion menu
          auto_show = false,
          winblend = 15,
          border = "rounded",
          scrollbar = false,
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
            treesitter = {
              "lsp",
            },

            components = {
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
              },
            },
          },
        },
      },
      cmdline = {
        keymap = {
          ["<C-n>"] = { "show", "show_documentation", "hide_documentation" },
          ["<Right>"] = { "accept", "fallback" },
          ["<CR>"] = {
            function(cmp)
              if cmp.is_menu_visible() then
                return cmp.accept()
              end
            end,
            "fallback",
          },
          ["<C-e>"] = { "hide", "fallback" },

          ["<Tab>"] = { "show", "select_next", "fallback" },
          ["<S-Tab>"] = { "select_prev", "fallback" },

          ["<C-b>"] = { "scroll_documentation_up", "fallback" },
          ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        },
      },
      keymap = {
        preset = "none",

        ["<C-n>"] = { "show", "show_documentation", "hide_documentation" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },

        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      },
      sources = {
        -- add lazydev to your completion providers
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    lazy = true,
    keys = {
      {
        "<leader>l",
        function()
          require("conform").format({
            -- lsp_fallback = true,
            async = true,
            timeout_ms = 1000,
          })
        end,
        desc = "Format file or range (in visual mode)",
        mode = { "n", "v" },
      },
    },
    opts = function()
      local opts = {
        formatters_by_ft = {
          lua = { "stylua", lsp_format = "never" },
          c = { "clang-format" },
          cpp = { "clang-format" },
          -- Conform will run multiple formatters sequentially
          python = { "isort", "black" },
          javascript = { "prettierd", "prettier" },
          typescript = { "prettierd", "prettier" },
          html = { "prettierd", "prettier" },
          vue = { "prettierd", "prettier" },
          css = { "prettierd", "prettier" },
          scss = { "prettierd", "prettier" },
          typescriptreact = { "prettierd", "prettier", "biome" },
          javascriptreact = { "prettierd", "prettier", "biome" },
          json = { "jq" },
        },
        formatters = {
          biome = { require_cwd = true },
          clang_format = {
            prepend_args = { "--style={BasedOnStyle: GNU, IndentWidth: 4}" },
          },
        },
        default_format_opts = {
          lsp_format = "never",
        },
      }
      return opts
    end,
  },
  {
    "mfussenegger/nvim-lint",
    lazy = true,
    event = { "bufreadpre", "bufnewfile" }, -- to disable, comment this out
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        c = { "cpplint" },
        cpp = { "cpplint" },
      }

      lint.linters.cpplint.args = {
        "--linelength=100 --filter=-build/class,-build/namespaces,-build/include_order,-whitespace/indent,-whitespace/parens,-whitespace/braces,-readability/namespace,-readability/function,-readability/nolint,-legal/copyright",
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "bufenter", "bufwritepost", "insertleave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
