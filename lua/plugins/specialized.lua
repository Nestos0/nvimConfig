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
    "zbirenbaum/copilot.lua",
    build = ":Copilot auth",
    lazy = true,
    cmd = "Copilot",
    opts = {
      suggestion = {
        enabled = true,
        debounce = 50,
        auto_trigger = true,
        keymap = {
          accept = "<M-m>",
        },
      },
      panel = { enabled = true },
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
    "yetone/avante.nvim",
    lazy = true,
    cmd = "AvanteAsk",
    keys = {
      {
        "<leader>aa",
        function()
          require("avante.api").ask()
        end,
        desc = "avante: ask",
        silent = true,
        noremap = true,
        mode = { "n", "v" },
      },
      {
        "<leader>an",
        function()
          require("avante.api").ask({ new_chat = true })
        end,
        desc = "avante: continue",
        silent = true,
        noremap = true,
        mode = { "n", "v" },
      },
    },
    version = false, -- set this to "*" if you want to always pull the latest change, false to update on release
    opts = {
      -- add any opts here

      provider = "deepseek",
      auto_suggestions_provider = "copilot", -- 使用 copilot 作为自动建议源
      compat = {
        "avante_commands",
        "avante_mentions",
        "avante_files",
      },
      providers = {
        deepseek = {
          __inherited_from = "openai",
          endpoint = "https://api.deepseek.com/",
          model = "deepseek-coder",
          timeout = 30000, -- Timeout in milliseconds
          extra_request_body = {
            temperature = 0,
          },
          max_tokens = 4096,
          -- optional
          api_key_name = "OPENAI_API_KEY", -- default OPENAI_API_KEY if not set
        },
        copilot = {
          name = "copilot",
          module = "avante.providers.copilot", -- 使用官方推荐的模块路径
          score_offset = 1000,
          opts = {
            auto_trigger = true,
            -- 添加推荐参数
            accept_key = "<M-CR>", -- Alt+Enter 接受建议
            dismiss_key = "<M-c>", -- Alt+c 取消建议
          },
        },
        avante_commands = {
          name = "avante_commands",
          module = "blink.compat.source",
          score_offset = 90, -- show at a higher priority than lsp
          opts = {},
        },
        avante_files = {
          name = "avante_commands",
          module = "blink.compat.source",
          score_offset = 100, -- show at a higher priority than lsp
          opts = {},
        },
        avante_mentions = {
          name = "avante_mentions",
          module = "blink.compat.source",
          score_offset = 1000, -- show at a higher priority than lsp
          opts = {},
        },
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      --- "hrsh7th/nvim-cmp",    -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
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
    },
  },
  {
    "S1M0N38/love2d.nvim",
    event = "VeryLazy",
    version = "2.*",
    opts = {},
    keys = {
      { "<leader>v", ft = "lua", desc = "LÖVE" },
      { "<leader>vv", "<cmd>LoveRun<cr>", ft = "lua", desc = "Run LÖVE" },
      { "<leader>vs", "<cmd>LoveStop<cr>", ft = "lua", desc = "Stop LÖVE" },
    },
  },
}
