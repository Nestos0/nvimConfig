return {
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
}
