local config = require("..config.statusline")

return {
  {
    "Bekaboo/dropbar.nvim",
    -- optional, but required for fuzzy finder support
    lazy = true,
    event = "User IceLoad",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    config = function()
      local dropbar_api = require("dropbar.api")
      vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
      vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
      vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    lazy = true,
    event = "User IceLoad",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = config,
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = "User IceLoad",
    lazy = true,
    keys = {
      { "<leader>b", "", desc = "Buffer" },
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bn", "<Cmd>BufferLinePick<CR>", desc = "Pick Buffer" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
      { "[b", "<Cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
      { "]b", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
      -- Add quick jump to buffers 1-9
      { "<leader>1", "<Cmd>lua require('bufferline').go_to(1, true)<CR>", desc = "Go to buffer 1" },
      { "<leader>2", "<Cmd>lua require('bufferline').go_to(2, true)<CR>", desc = "Go to buffer 2" },
      { "<leader>3", "<Cmd>lua require('bufferline').go_to(3, true)<CR>", desc = "Go to buffer 3" },
      { "<leader>4", "<Cmd>lua require('bufferline').go_to(4, true)<CR>", desc = "Go to buffer 4" },
      { "<leader>5", "<Cmd>lua require('bufferline').go_to(5, true)<CR>", desc = "Go to buffer 5" },
      { "<leader>6", "<Cmd>lua require('bufferline').go_to(6, true)<CR>", desc = "Go to buffer 6" },
      { "<leader>7", "<Cmd>lua require('bufferline').go_to(7, true)<CR>", desc = "Go to buffer 7" },
      { "<leader>8", "<Cmd>lua require('bufferline').go_to(8, true)<CR>", desc = "Go to buffer 8" },
      { "<leader>9", "<Cmd>lua require('bufferline').go_to(9, true)<CR>", desc = "Go to buffer 9" },
      { "<leader>0", "<Cmd>lua require('bufferline').go_to(-1, true)<CR>", desc = "Go to last buffer" },
    },
    opts = {
      options = {
        mode = "buffers",
        disgnostics = "nvim_lsp",
        separator_style = "slant",
        numbers = "ordinal",
        always_show_bufferline = true, -- Hide bufferline when only one buffer
        auto_toggle_bufferline = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "center",
            separator = false,
          },
        },
      },
    },
  },
}
