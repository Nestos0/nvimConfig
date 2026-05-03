return {
  {
    "3rd/image.nvim",
    lazy = true,
    ft = { "markdown", "Yazi" },
    dependencies = { "luarocks.nvim" },
    enabled = function()
      return not vim.g.neovide
    end,
    opts = {
      backend = "kitty",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = true,
          filetypes = { "markdown", "vimwiki", "Yazi" }, -- markdown extensions (ie. quarto) can go here
          resolve_image_path = function(document_path, image_path, fallback)
            return fallback(document_path, image_path)
          end,
        },
        html = {
          enabled = false,
        },
        css = {
          enabled = false,
        },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = nil,
      max_height_window_percentage = 50,
      window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
      tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
    },
  },
  {
    -- support for image pasting
    "HakonHarnes/img-clip.nvim",
    lazy = true,
    event = "User IceLoad",
    keys = {
      -- suggested keymap
      { "<leader>P", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
    opts = {
      -- recommended settings
      default = {
        embed_image_as_base64 = false,
        prompt_for_file_name = false,
        drag_and_drop = {
          insert_mode = true,
        },
        -- required for Windows users
        use_absolute_path = true,
      },
    },
  },
  {
    "nickjvandyke/opencode.nvim",
    version = "*", -- Latest stable release
    dependencies = {
      {
        -- `snacks.nvim` integration is recommended, but optional
        ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
        "folke/snacks.nvim",
        optional = true,
        opts = {
          input = {}, -- Enhances `ask()`
          picker = { -- Enhances `select()`
            actions = {
              opencode_send = function(...)
                return require("opencode").snacks_picker_send(...)
              end,
            },
            win = {
              input = {
                keys = {
                  ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                },
              },
            },
          },
        },
      },
    },
    config = function()
      vim.g.opencode_opts = {
        -- Your configuration, if any; goto definition on the type or field for details
      }

      vim.o.autoread = true -- Required for `opts.events.reload`

      -- Recommended/example keymaps
      vim.keymap.set({ "n", "x" }, "<A-a>", function()
        require("opencode").ask("@this: ", { submit = true })
      end, { desc = "Ask opencode…" })
      vim.keymap.set({ "n", "x" }, "<A-x>", function()
        require("opencode").select()
      end, { desc = "Execute opencode action…" })
      vim.keymap.set({ "n", "t" }, "<C-.>", function()
        require("opencode").toggle()
      end, { desc = "Toggle opencode" })

      vim.keymap.set({ "n", "x" }, "go", function()
        return require("opencode").operator("@this ")
      end, { desc = "Add range to opencode", expr = true })
      vim.keymap.set("n", "goo", function()
        return require("opencode").operator("@this ") .. "_"
      end, { desc = "Add line to opencode", expr = true })

      vim.keymap.set("n", "<S-C-u>", function()
        require("opencode").command("session.half.page.up")
      end, { desc = "Scroll opencode up" })
      vim.keymap.set("n", "<S-C-d>", function()
        require("opencode").command("session.half.page.down")
      end, { desc = "Scroll opencode down" })

      -- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
      vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
      vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
    end,
  },
  {
    "S1M0N38/love2d.nvim",
    -- event = "VeryLazy",
    version = "2.*",
    opts = {},
    keys = {
      { "<leader>v", ft = "lua", desc = "LÖVE" },
      { "<leader>vv", "<cmd>LoveRun<cr>", ft = "lua", desc = "Run LÖVE" },
      { "<leader>vs", "<cmd>LoveStop<cr>", ft = "lua", desc = "Stop LÖVE" },
    },
  },
}
