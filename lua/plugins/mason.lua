return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    lazy = true,
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
      },
    },
    -- mason-nvim-dap is loaded when nvim-dap loads
    config = function() end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = true,
    cmd = "MasonToolsInstall",
    config = function()
      require("mason-tool-installer").setup({

        -- a list of all tools you want to ensure are installed upon
        ensure_installed = {
          -- you can turn off/on auto_update per tool
          { "bash-language-server", auto_update = true },

          --'lua-language-server',
          "vim-language-server",
          "clang-format",
          "stylua",
          "prettierd",
          "prettier",
          "black",
          "isort",
          "shellcheck",
          "shellcheck",
          "shfmt",
          "vint",
        },
      })
    end,
  },
  {
    "mason-org/mason.nvim",
    lazy = true,
    event = "User IceLoad",
    cmd = "Mason",
    opts = {},
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      "stevearc/dressing.nvim",
    },
    config = function(_, opts)
      require("mason").setup(opts)
      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd",
          "html",
          "bashls",
          "eslint",
          "pyright",
          "jsonls",
          "emmet_ls",
          "emmet_language_server",
          "dockerls",
          "docker_compose_language_service",
          "nginx_language_server",
          "eslint",
          "serve_d"
        },
        automatic_enable = {},
      })
    end,
  },
}
