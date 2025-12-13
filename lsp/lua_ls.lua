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
    },
  },
}
