return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    lazy = true,
    ft = { "markdown", "Avante*" },
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
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
        mode = { "n", "v" }
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
          json = { "jq" }
        },
        formatters = {
          biome = { require_cwd = true },
        },
        default_format_opts = {
          lsp_format = "never",
        },
      }
      return opts
    end,
  },
}
