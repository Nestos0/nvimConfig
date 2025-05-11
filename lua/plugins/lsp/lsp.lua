local lsp = {}
lsp = {
  sqlls = {},
  dockerls = {},
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          -- disable = { "undefined-field" },
          globals = { "vim" },
        },
      },
    },
  },
  cssls = {},
  html = {},
  jsonls = {},
  pyright = {},
  volar = {
    filetypes = { "vue" },
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
