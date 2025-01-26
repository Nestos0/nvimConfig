return {
	{
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		opts = {
			--Config goes here
			fastwarp = {
				enable = true,
				map = "<A-k>",
				rmap = "<A-K>",
				cmap = "<A-k>",
				rcmap = "<A-K>",
			},
			internal_pairs = {
				{ ">", "<", ft = { "markdown", "html", "vue" }, space = true, newline = true },
				{ "[", "]", fly = true, dosuround = true, newline = true, space = true },
				{ "(", ")", fly = true, dosuround = true, newline = true, space = true },
				{ "{", "}", fly = true, dosuround = true, newline = true, space = true },
				{ '"', '"', suround = true, multiline = false },
				{
					"'",
					"'",
					suround = true,
					cond = function(fn)
						return not fn.in_lisp() or fn.in_string()
					end,
					alpha = true,
					nft = { "tex" },
					multiline = false,
				},
				{
					"`",
					"`",
					cond = function(fn)
						return not fn.in_lisp() or fn.in_string()
					end,
					nft = { "tex" },
					multiline = false,
				},
				{ "``", "''", ft = { "tex" } },
				{ "```", "```", newline = true, ft = { "markdown" } },
				{ "<!--", "-->", ft = { "markdown", "html" }, space = true },
				{ '"""', '"""', newline = true, ft = { "python" } },
				{ "'''", "'''", newline = true, ft = { "python" } },
			},
		},
	},
	{
		"abecodes/tabout.nvim",
		lazy = false,
		config = function()
			require("tabout").setup({
				tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
				backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
				act_as_tab = true, -- shift content if tab out is not possible
				act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
				default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
				default_shift_tab = "<C-d>", -- reverse shift default action,
				enable_backwards = true, -- well ...
				completion = false, -- if the tabkey is used in a completion pum
				tabouts = {
					{ open = "'", close = "'" },
					{ open = '"', close = '"' },
					{ open = "`", close = "`" },
					{ open = "(", close = ")" },
					{ open = "[", close = "]" },
					{ open = "{", close = "}" },
				},
				ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
				exclude = {}, -- tabout will ignore these filetypes
			})
		end,
		dependencies = { -- These are optional
			"nvim-treesitter/nvim-treesitter",
		},
		opt = true, -- Set this to true if the plugin is optional
		event = "InsertCharPre", -- Set the event to 'InsertCharPre' for better compatibility
		priority = 1000,
	},
}
