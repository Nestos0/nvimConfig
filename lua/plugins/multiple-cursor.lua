return {
	{
		"Nestos0/multiple-cursors.nvim",
		enabled = false,
		version = "*", -- Use the latest tagged version
		opts = function()
			local opts = {}
			return opts
		end,
		-- This causes the plugin setup function to be called
		keys = {
			{
				"<C-e>",
				"<Cmd>MultipleCursorsAddDown<CR>",
				mode = { "n", "x" },
				desc = "Add cursor and move down",
			},
			{ "<C-u>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "x" }, desc = "Add cursor and move up" },

			{ "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "i", "x" }, desc = "Add cursor and move up" },
			{
				"<C-Down>",
				"<Cmd>MultipleCursorsAddDown<CR>",
				mode = { "n", "i", "x" },
				desc = "Add cursor and move down",
			},

			{
				"<C-LeftMouse>",
				"<Cmd>MultipleCursorsMouseAddDelete<CR>",
				mode = { "n", "i" },
				desc = "Add or remove cursor",
			},

			{
				"<Leader>a",
				"<Cmd>MultipleCursorsAddMatches<CR>",
				mode = { "n", "x" },
				desc = "Add cursors to cword",
			},
			{
				"<Leader>A",
				"<Cmd>MultipleCursorsAddMatchesV<CR>",
				mode = { "n", "x" },
				desc = "Add cursors to cword in previous area",
			},

			{
				"<Leader>d",
				"<Cmd>MultipleCursorsAddJumpNextMatch<CR>",
				mode = { "n", "x" },
				desc = "Add cursor and jump to next cword",
			},
			{ "<Leader>D", "<Cmd>MultipleCursorsJumpNextMatch<CR>", mode = { "n", "x" }, desc = "Jump to next cword" },

			{
				"<Leader>l",
				"<Cmd>MultipleCursorsLock<CR>",
				mode = { "n", "x" },
				desc = "Lock virtual cursors",
			},
		},
	},
}
