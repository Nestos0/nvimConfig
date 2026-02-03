local library = {
  unpack(vim.api.nvim_get_runtime_file("", true)),
  vim.fn.expand(
    "$HOME/.local/share/nvim/mason/packages/lua-language-server/libexec/meta/3rd/love2d"
  ),
}

return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },

      diagnostics = {
        globals = { "vim", "love", "conf" },
      },

      telemetry = {
        enable = false,
      },

      workspace = {
        library = library,
        checkThirdParty = false,
      },
    },
  },
}
