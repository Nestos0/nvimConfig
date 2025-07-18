return {
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
}
