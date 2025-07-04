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

          -- you can pin a tool to a particular version
          { "golangci-lint", version = "v1.47.0" },

          -- you can turn off/on auto_update per tool
          { "bash-language-server", auto_update = true },

          --'lua-language-server',
          "vim-language-server",
          "gopls",
          "clang-format",
          "stylua",
          "prettierd",
          "prettier",
          "black",
          "isort",
          "shellcheck",
          "gofumpt",
          "golines",
          "gomodifytags",
          "gotests",
          "impl",
          "jq",
          "misspell",
          "revive",
          "shellcheck",
          "shfmt",
          "staticcheck",
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
      "neovim/nvim-lspconfig",
      "mason-org/mason-lspconfig.nvim",
      "stevearc/dressing.nvim",
    },
    config = function(_, opts)
      require("mason").setup(opts)
      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd",
          "lua_ls",
          "jqls",
          "gopls",
          "html",
          "bashls",
          "jqls",
          "eslint",
          "pyright",
          "jsonls",
          "vue_ls",
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
