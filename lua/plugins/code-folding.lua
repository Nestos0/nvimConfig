return {
	{
		"kevinhwang91/nvim-ufo",
    lazy = true,
    keys = {
      { "za" },
      { "zR", function() require("ufo").openAllFolds() end, desc = "open all folds"},
      { "zM", function() require("ufo").closeAllFolds() end, desc = "close all folds"}
    },
		dependencies = "kevinhwang91/promise-async",
		opts = function()
			vim.o.foldcolumn = "1" -- '0' is not bad
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}
			local language_servers = vim.lsp.config
            -- or list servers manually like {'gopls', 'clangd'}
			for _, ls in ipairs(language_servers) do
				require("lspconfig")[ls].setup({
					capabilities = capabilities,
					-- you can add other fields for setting up lsp server in this table
				})
			end
            return {}
		end,
	},
}
