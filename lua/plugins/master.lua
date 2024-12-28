return {

	-- Used to define a keymap
	{ "LionC/nest.nvim" },

	-- Theme
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	-- Auto-Pairs
	{
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		config = function()
			require("ultimate-autopair").setup({
				--Config goes here
				fastwarp = {
					enable = true,
					map = "<A-k>",
					rmap = "<A-K>",
					cmap = "<A-k>",
					crmap = "<A-K>",
				},
			})
		end,
	},
	{
		"karb94/neoscroll.nvim",
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
	"nvim-tree/nvim-web-devicons"
}
