return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {},
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
	},
	{
		"chentoast/marks.nvim",
		config = function()
			require("marks").setup({
				default_mappings = true,
			})
		end,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"stevearc/conform.nvim",
		opts = function()
			local conform = require("conform")
			vim.keymap.set({ "n", "v" }, "<leader>l", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end, { desc = "Format file or range (in visual mode)" })
			local opts = {
				formatters_by_ft = {
					lua = { "stylua" },
					-- Conform will run multiple formatters sequentially
					python = { "isort", "black" },
					javascript = { { "prettierd", "prettier" } },
					typescript = { { "prettierd", "prettier" } },
					typescriptreact = { { "prettierd", "prettier", "biome" } },
					javascriptreact = { { "prettierd", "prettier", "biome" } },
				},
                formatters = {
                    biome = { require_cwd = true }
                }
			}
			return opts
		end,
	},
}
