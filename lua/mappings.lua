local nest = require("nest")

nest.applyKeymaps({
	{
		"<leader>",
		{
			{
				"sa",
				'<cmd>!wl-paste | fold -w1 | sort | paste -sd "" | paste -sd "" | tr -d \'\\n\' | wl-copy<CR><CR>',
				options = { silent = true, desc = "Sort copied by alphabet" },
			},
		},
	},
	{
		{ "u", "<up>", options = { desc = "Up" } },
		{ "n", "<left>", options = { desc = "Left" } },
		{ "i", "<right>", options = { desc = "Right" } },
		{ "e", "<down>", options = { desc = "Down" } },
		{ "j", "<undo>", options = { desc = "Undo" } },
		{ "J", "<redo>", options = { desc = "Redo" } },
		{ "w", "<Insert>", options = { desc = "Insert" } },
		{ "l", "w", options = { desc = "Forward to next word" } },
		{ "h", "n", options = { desc = "Repeat latest find" } },
		{ "k", "e", options = { desc = "Forward to next word end" } },
		{
			"<S-",
			{
				{ "u>", "<C-U>", options = { desc = "Scroll Up" } },
				{ "e>", "<C-D>", options = { desc = "Scroll Down" } },
				{ "w>", "I", options = { desc = "Insert start" } },
				{ "l>", "W", options = { desc = "Forward to next WORD" } },
				{ "n>", "^", options = { desc = "Cursor to Begin of line" } },
				{ "i>", "$", options = { desc = "Cursor to End of line" } },
				{ "h>", "N", options = { desc = "Repeat latest find(opposite)" } },
				{ "k>", "E", options = { desc = "Forward to next WORD end" } },
			},
		},
		{
			"<C-",
			{
				{ "-f>", "<Pageup>" },
				{ "-b>", "<Pagedown>" },
				{ "-LeftMouse>", "<Nop>" },
			},
		},
		{
			"<C-w>",
			{
				{ "n", "<C-w><left>" },
				{ "i", "<C-w><right>" },
				{ "e", "<C-w><down>" },
				{ "u", "<C-w><up>" },
				{ "N", "<C-w>H" },
				{ "I", "<C-w>L" },
				{ "E", "<C-w>J" },
				{ "U", "<C-w>K" },
			},
		},
		{
			"<A-",
			{
				{ "V>", "<cmd>vsplit<CR>" },
				{ "B>", "<cmd>split<CR>" },
				{ "q>", "<cmd>bd | bp<CR>" },
				{ "m>", "<cmd>Neotree toggle<CR>", options = { desc = "Toggle Neotree" } },
			},
		},
		{
			"g",
			{
				{ "l", "ge", options = { desc = "Backward to next word end" } },
				{ "L", "gE", options = { desc = "Backward to next WORD end" } },
				{ "u", "gk", options = { desc = "Move cursor up one display line" } },
				{ "e", "gj", options = { desc = "Move cursor down one display line" } },

			}
		},
	},
}, {
	mode = "nx",
	prefix = "",
	buffer = false,
	options = { noremap = true, silent = true },
})
