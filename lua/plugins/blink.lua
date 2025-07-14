return {
  { -- optional blink completion source for require statements and module annotations
    "saghen/blink.cmp",
    lazy = true,
    version = "*",
    build = "cargo build --release",
    dependencies = {
      "rafamadriz/friendly-snippets",
      { 'Nestos0/colorful-menu.nvim', opts = {} },
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
}
