return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "c", "lua", "vim", "vimdoc", "javascript", "html", "ruby", "go" },
			sync_install = true,
			highlight = { enable = true },
			indent = { enable = true },
			endwise = {
				enable = true,
			},
		},
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = true,
		opts = {
			enable_autocmd = false,
		},
	},
}
