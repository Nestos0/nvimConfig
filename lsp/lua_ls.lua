return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  settings = {
    Lua = {
      diagnostics = {
        -- disable = { "undefined-field" },
        globals = { "vim", "love" },
      },
      globals = {
        "love",
        "conf",
        -- 如果您自定义了全局对象，也放在这里
      },
      workspace = {
        library = {
          [vim.fn.expand("$HOME/.local/share/nvim/mason/packages/lua-language-server/libexec/meta/3rd/love2d")] = true,
        },
        checkThirdParty = false,
      },
    },
  },
}
