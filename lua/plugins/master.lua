return {
	{
		"pairtest.nvim",
		dev = true,
		-- opts = {},
	},
	"nvim-lua/plenary.nvim",
	-- Used to define a keymap
	{ "LionC/nest.nvim" },

	-- Theme
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	-- Which Key
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	"nvim-tree/nvim-web-devicons",
	{
		"vhyrro/luarocks.nvim",
    lazy = true,
    cmd = "Luarocks",
		priority = 9001, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
		opts = {
			rocks = { "promise-async", "magick" }, -- specifies a list of rocks to install
			-- luarocks_build_args = { "--with-lua=/my/path" }, -- extra options to pass to luarocks's configuration script
		},
	},
}
