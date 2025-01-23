return {
	{ "rime_ls", dev = true, dir = vim.fn.stdpath("config") .. "/" .. "rime_ls" },
	"VonHeikemen/lsp-zero.nvim",
	-- "jbyuki/one-small-step-for-vimkind",
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
		event = "InsertEnter",
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
						preselect = function(ctx)
							return ctx.mode ~= "cmdline" and not require("blink.cmp").snippet_active({ direction = 1 })
						end,
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

				["<C-n>"] = { "show", "show_documentation", "hide_documentation" },
				["<CR>"] = { "accept", "fallback" },
				["<C-e>"] = { "hide", "fallback" },

				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },

				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
				["<space>"] = {
					function(cmp)
						if not vim.g.rime_enabled then
							return false
						end
						local rime_item_index = require("rime_ls").get_n_rime_item_index(1)
						if #rime_item_index ~= 1 then
							return false
						end
						-- If you want to select more than once,
						-- just update this cmp.accept with vim.api.nvim_feedkeys('1', 'n', true)
						-- The rest can be updated similarly
						return cmp.accept({ index = rime_item_index[1] })
					end,
					"fallback",
				},
				[";"] = {
					-- FIX: can not work when binding ;<space> to other functionality
					-- such inputting a Chinese punctuation
					function(cmp)
						if not vim.g.rime_enabled then
							return false
						end
						local rime_item_index = require("rime_ls").get_n_rime_item_index(2)
						if #rime_item_index ~= 2 then
							return false
						end
						return cmp.accept({ index = rime_item_index[2] })
					end,
					"fallback",
				},
				["'"] = {
					function(cmp)
						if not vim.g.rime_enabled then
							return false
						end
						local rime_item_index = require("rime_ls").get_n_rime_item_index(3)
						if #rime_item_index ~= 3 then
							return false
						end
						return cmp.accept({ index = rime_item_index[3] })
					end,
					"fallback",
				},
			},
			sources = {
				-- add lazydev to your completion providers
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				cmdline = { "cmdline", "lazydev" },
				providers = {
					lsp = {
						transform_items = function(_, items)
							-- the default transformer will do this
							for _, item in ipairs(items) do
								if item.kind == require("blink.cmp.types").CompletionItemKind.Snippet then
									item.score_offset = item.score_offset - 3
								end
							end
							-- you can define your own filter for rime item
							return items
						end,
					},
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
