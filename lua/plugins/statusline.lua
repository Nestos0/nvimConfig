local config = require("..config.statusline")

return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = config
	},
	{
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        opts = {
            options = {
                mode = "buffers",
                separator_style = "slant",
                numbers = "ordinal",
                hover = {
                    enabled = true,
                    delay = 200,
                    reveal = {'close'}
                },
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "Neo-tree",
                        highlight = "Directory",
                        text_align = "center",
                        separator = true
                    }
                },
            }
        }
    },
}
