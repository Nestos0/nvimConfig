local mason_bin_path = vim.fn.stdpath("data") .. "/mason/bin/"
local mason_package_path = vim.fn.stdpath("data") .. "/mason/packages/"

local vtsls_opts = {
  name = "vtsls",
  cmd = { mason_bin_path .. "vtsls", "--stdio" },
  root_dir = vim.fs.root(0, { "package.json", "tsconfig.json", "jsconfig.json", ".git" }),
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          {
            name = "@vue/typescript-plugin",
            location = mason_package_path .. "vue-language-server/node_modules/@vue/language-server",
            languages = { "vue" },
            configNamespace = "typescript",
          },
        },
      },
    },
  },
}

local vue_ls_opts = {
  name = "vue_ls",
  cmd = { mason_bin_path .. "vue-language-server", "--stdio" },
  root_dir = vim.fs.root(0, { "package.json", "vite.config.ts", "vue.config.js", "vite.config.js", ".git" }),
  on_init = function(client)
    client.handlers["tsserver/request"] = function(_, result, context)
      local vtsls_clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
      if #vtsls_clients == 0 then return end
      local ts_client = vtsls_clients[1]
      local param = unpack(result)
      local id, command, payload = unpack(param)
      ts_client:exec_cmd({
        command = "typescript.tsserverRequest",
        arguments = { command, payload },
      }, { bufnr = context.bufnr }, function(_, r)
        local response = r and r.body
        client:notify("tsserver/response", { { id, response } })
      end)
    end
  end,
}

local html_opts = {
  name = "html",
  cmd = { mason_bin_path .. "vscode-html-language-server", "--stdio" },
  root_dir = vim.fs.root(0, { "package.json", ".git" }),
}

local lsp_group = vim.api.nvim_create_augroup("UserVueLspConfig", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = lsp_group,
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
  callback = function(args)
    vim.lsp.start(vtsls_opts)
    if vim.bo[args.buf].filetype == "vue" then
      vim.lsp.start(vue_ls_opts)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = lsp_group,
  pattern = { "html" },
  callback = function()
    vim.lsp.start(html_opts)
  end,
})

vim.lsp.enable({ "lua_ls", "clangd", "pyright", "hls", "cssls" })
vim.lsp.config("rust_analyzer", { cmd = { "rust-analyzer" }, filetypes = { "rust" } })
vim.lsp.enable("rust_analyzer")
