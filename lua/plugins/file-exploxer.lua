M = {
	{
		"s1n7ax/nvim-window-picker",
		version = "2.*",
		opts = {
			filter_rules = {
				include_current_win = false,
				autoselect_one = true,
				-- filter using buffer options
				bo = {
					-- if the file type is one of following, the window will be ignored
					filetype = { "neo-tree", "neo-tree-popup", "notify" },
					-- if the buffer type is one of following, the window will be ignored
					buftype = { "terminal", "quickfix" },
				},
			},
		},
	},
	"MunifTanjim/nui.nvim",
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"s1n7ax/nvim-window-picker",
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		opts = {
			source_selector = {
				winbar = true,
				statusline = false,
			},
			window = {
				mappings = {
					["e"] = "noop",
					["ge"] = "toggle_auto_expand_width",
				},
			},

			buffers = {
				window = {
					mappings = {
						["i"] = "noop",
						["gi"] = "show_file_details",
					},
				},
			},
		},
	},
	{
		"mikavilpas/yazi.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		event = "VeryLazy",
		keys = {
			{
				-- 👇 choose your own keymapping
				"<leader>-",
				function()
					require("yazi").yazi()
				end,
				{ desc = "Open the file manager" },
			},
		},
		opts = {}
	},
}

-- If you want icons for diagnostic errors, you'll need to define them somewhere:
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

vim.cmd([[nnoremap \ :Neotree reveal<cr>]])

return M
