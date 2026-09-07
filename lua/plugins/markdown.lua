return {
  {
    "timantipov/md-table-tidy.nvim",
    opts = {
      padding = 1, -- number of spaces for cell padding
      keymap = {
        table_tidy = "<leader>tt", -- key for command :TableTidy<CR>
        table_tidy_all = "<leader>ta", -- key for command :TableTidyAll<CR>
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    lazy = true,
    ft = { "markdown", "Avante*" },
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
}
