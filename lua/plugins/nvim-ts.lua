return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "c", "lua", "vim", "vimdoc", "javascript", "html" },
			sync_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		},
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
	},
}
