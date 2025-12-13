return {
  cmd = { "clangd" },
  filetypes = { "c", "cpp" },
  on_init = function(client)
    if client.server_capabilities.foldingRangeProvider then
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.lsp.foldexpr()"
    end
  end,

  on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "<leader>h", function()
      vim.lsp.buf.hover()
    end, opts)

    vim.keymap.set("i", "<C-s>", function()
      vim.lsp.buf.signature_help()
    end, opts)

    vim.keymap.set("n", "gd", function()
      vim.lsp.buf.definition()
    end, opts)
    vim.keymap.set("n", "<leader>ws", function()
      vim.lsp.buf.workspace_symbol()
    end, opts)
    vim.keymap.set("n", "<leader>d", function()
      vim.diagnostic.open_float()
    end, opts)
    vim.keymap.set("n", "[d", function()
      vim.diagnostic.jump({ count = 1 })
    end, opts)
    vim.keymap.set("n", "]d", function()
      vim.diagnostic.jump({ count = -1 })
    end, opts)
    vim.keymap.set("n", "<leader>ca", function()
      vim.lsp.buf.code_action()
    end, opts)
    vim.keymap.set("n", "<leader>rr", function()
      vim.lsp.buf.references()
    end, opts)
    vim.keymap.set("n", "<leader>rn", function()
      vim.lsp.buf.rename()
    end, opts)
  end,

  settings = {
    clangd = {
      InlayHints = {
        Enabled = false,
        ParameterNames = true,
        DeducedTypes = true,
      },
    },
  },
}
