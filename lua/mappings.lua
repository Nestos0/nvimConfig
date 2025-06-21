local nest = require("nest")

nest.applyKeymaps({
  {
    "<leader>",
    {
      {
        "d",
        "",
        options = { desc = "Dap" },
      },
      {
        "u",
        "",
        options = { desc = "Undo" },
      },
      {
        "s",
        {
          { "", "", options = { desc = "Sort OR Noice" } },
          {
            "a",
            '<cmd>!wl-paste | fold -w1 | sort | paste -sd "" | paste -sd "" | tr -d \'\\n\' | wl-copy<CR><CR>',
            options = { silent = true, desc = "Sort copied by alphabet" },
          },
        },
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
    { "d", '"_d', options = { desc = "Delete" } },
    { "c", '"_c', options = { desc = "Change" } },
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
        { "-u>", "<C-y>" },
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
      },
    },
    {
      "g",
      {
        { "l", "ge", options = { desc = "Backward to next word end" } },
        { "L", "gE", options = { desc = "Backward to next WORD end" } },
        { "u", "gk", options = { desc = "Move cursor up one display line" } },
        { "e", "gj", options = { desc = "Move cursor down one display line" } },
      },
    },
  },
}, {
  mode = "nx",
  prefix = "",
  buffer = false,
  options = { noremap = true, silent = true },
})

function HexToRGBA()
  local hex = vim.fn.expand("<cword>") -- 获取光标下的单词
  local r, g, b = hex:match("#?(%x%x)(%x%x)(%x%x)")
  if r and g and b then
    r, g, b = tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)
    vim.fn.setreg("+", string.format("rgba(%d, %d, %d, 1)", r, g, b)) -- 复制到剪贴板
    print("Copied: rgba(" .. r .. ", " .. g .. ", " .. b .. ", 1)")
  else
    print("Not a valid hex color!")
  end
end

vim.api.nvim_set_keymap("n", "<leader>cr", ":lua HexToRGBA()<CR>", { noremap = true, silent = true })
