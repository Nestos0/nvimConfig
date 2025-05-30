return {
  {
    "pmizio/typescript-tools.nvim",
    lazy = true,
    ft = { "typescript", "javascript", "vue" },
    -- enabled = false,
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = function()
      local api = require("typescript-tools.api")
      return {
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
  -- { "nvimtools/none-ls.nvim", dependencies = "nvim-lua/plenary.nvim" },
  -- "VonHeikemen/lsp-zero.nvim",
  "rafamadriz/friendly-snippets",
  {
    "neovim/nvim-lspconfig",
    -- lazy = true,
    -- event = { "InsertEnter", "CmdlineEnter", "User IceLoad" },
    config = function()
      local lspconfig = require("lspconfig")
      for server, config in pairs(Lazy.lsp) do
        config.capabilities = require("blink.cmp").get_lsp_capabilities({
          textDocument = { completion = { completionItem = { snippetSupport = true } } },
        })
        lspconfig[server].setup(config)
      end
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
    build = "cargo build --release",
    dependencies = {
      "rafamadriz/friendly-snippets",
      { 'xzbdmw/colorful-menu.nvim', opts = {} },
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
          auto_show = true,
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
}
