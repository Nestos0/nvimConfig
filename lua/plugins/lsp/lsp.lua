local lsp = {}
lsp = {
  sqlls = {},
  dockerls = {},
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          -- disable = { "undefined-field" },
          globals = { "vim", "love" },
        },
      },
    },
  },
  cssls = {
    settings = {
      css = {
        lint = {
          unknownAtRules = "ignore",
        },
      },
    },
  },
  html = {},
  jsonls = {},
  pyright = {},
  -- eslint = {},
  clangd = {
    cmd = {
      "clangd",
      "--background-index",
      "--fallback-style=GNU",
      "--compile-commands-dir=build",
      "--all-scopes-completion",
      "--clang-tidy",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--pretty",
      "-j=8",
    },
    on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, remap = false }

      vim.keymap.set("n", "gd", function()
        vim.lsp.buf.definition()
      end, opts)
      vim.keymap.set("n", "<C-n>", function()
        vim.lsp.buf.hover()
      end, opts)
      vim.keymap.set("n", "<leader>vws", function()
        vim.lsp.buf.workspace_symbol()
      end, opts)
      vim.keymap.set("n", "<leader>vd", function()
        vim.diagnostic.open_float()
      end, opts)
      vim.keymap.set("n", "[d", function()
        vim.diagnostic.goto_next()
      end, opts)
      vim.keymap.set("n", "]d", function()
        vim.diagnostic.goto_prev()
      end, opts)
      vim.keymap.set("n", "<leader>vca", function()
        vim.lsp.buf.code_action()
      end, opts)
      vim.keymap.set("n", "<leader>vrr", function()
        vim.lsp.buf.references()
      end, opts)
      vim.keymap.set("n", "<leader>vrn", function()
        vim.lsp.buf.rename()
      end, opts)
      vim.keymap.set("i", "<C-h>", function()
        vim.lsp.buf.signature_help()
      end, opts)
    end,
  },
  serve_d = {},
  volar = {
    filetypes = { "vue" },
    settings = {
      css = {
        lint = {
          unknownAtRules = "ignore",
        },
      },
    },
    init_options = {
      typescript = {
        tsdk = "/usr/lib/node_modules/typescript/lib/",
      },
      vue = {
        -- disable hybrid mode
        hybridMode = false,
      },
    },
  },
}

Lazy.lsp = lsp
