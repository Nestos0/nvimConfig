local nest = require("nest")
local scroll = require("neoscroll")

nest.applyKeymaps({
    {
        "<leader>", {
            {
                "sa",
                '<cmd>!wl-paste | fold -w1 | sort | paste -sd "" | paste -sd "" | tr -d \'\\n\' | wl-copy<CR><CR>',
                options = { silent = true, desc = "Sort copied by alphabet" }
            }
        }
    },
		{
        { "u", "<up>", options = { desc = "Up" } },
				{ "n", "<left>", options = { desc = "Left" } },
				{ "i", "<right>", options = { desc = "Right" } },
				{ "e", "<down>" },
        { "j", "<undo>" },
				{ "J", "<redo>" },
				{ "w", "<Insert>" },
				{ "k", "w" },
        { "h", "n" }, 
				{
            "<S-", {
                {"k>", "W"},
								{"n>", "^"}, 
								{"i>", "$"}, 
								{"h>", "N"},
            }
        },
        {
            "<C-",
            {
                {"-f>", "<Pageup>"}, {"-b>", "<Pagedown>"},
                {"-LeftMouse>", "<Nop>"}
            }
        }, {
            "<C-w>", {
                {"n", "<C-w><left>"}, 
								{"i", "<C-w><right>"},
                {"e", "<C-w><down>"}, 
								{"u", "<C-w><up>"}, 
								{"N", "<C-w>H"},
                {"I", "<C-w>L"}, 
								{"E", "<C-w>J"}, 
								{"U", "<C-w>K"}
            }
        }, {
            "<A-", {
								{"V>", "<cmd>vsplit<CR>"},
                {"B>", "<cmd>split<CR>"}, 
								{"q", "<cmd>bd | bp<CR>"}
            }
        }
    }
}, 
{
    mode = "nx",
    prefix = "",
    buffer = false,
    options = {noremap = true, silent = true}
})

