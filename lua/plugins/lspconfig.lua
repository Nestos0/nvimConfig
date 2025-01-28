return {
	"VonHeikemen/lsp-zero.nvim",
	"jay-babu/mason-nvim-dap.nvim",
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"rafamadriz/friendly-snippets",
	"neovim/nvim-lspconfig",
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{ -- optional blink completion source for require statements and module annotations
		"saghen/blink.cmp",
		build = "cargo build --release",
		dependencies = {
			"rafamadriz/friendly-snippets",
			-- add blink.compat to dependencies
			{
				"saghen/blink.compat",
				opts = {},
				lazy = true,
				version = "*",
			},
		},
		event = "VeryLazy",
		opts = {
			completion = {
				accept = {
					-- experimental auto-brackets support
					auto_brackets = {
						enabled = true,
					},
				},
				menu = {
					draw = {
						treesitter = { "lsp" },
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
				},
				list = {
					selection = {
						preselect = false
					},
				},
			},
			keymap = {
				preset = "none",
				cmdline = {
					["<C-n>"] = { "show", "show_documentation", "hide_documentation" },
					["<CR>"] = { "accept", "fallback" },
					["<C-e>"] = { "hide", "fallback" },

					["<Tab>"] = { "show", "select_next", "fallback" },
					["<S-Tab>"] = { "select_prev", "fallback" },

					["<C-b>"] = { "scroll_documentation_up", "fallback" },
					["<C-f>"] = { "scroll_documentation_down", "fallback" },
				},

				snippets = {
					["<CR>"] = { "accept", "fallback" },
				},

				["<C-n>"] = { "show", "show_documentation", "hide_documentation" },
				["<CR>"] = { "accept", "fallback" },
				["<C-e>"] = { "hide", "fallback" },

				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },

				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
			},
			sources = {
				-- add lazydev to your completion providers
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				cmdline = { "cmdline" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
				},
			},
		},
	},
}
