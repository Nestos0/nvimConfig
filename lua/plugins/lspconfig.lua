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
    "luckasRanarison/tailwind-tools.nvim",
    lazy = true,
    ft = { "vue", "html", "css", "javascript" },
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
      "neovim/nvim-lspconfig", -- optional
    },
    opts = {}, -- your configuration
  },
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
}
