return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  settings = {
    Lua = {
      diagnostics = {
        -- disable = { "undefined-field" },
        globals = { "vim", "love" },
      },
    },
  },
}
