local nest = require("nest")

local function HexToRGBA()
  local hex = vim.fn.expand("<cword>")
  local r, g, b = hex:match("#?(%x%x)(%x%x)(%x%x)")
  if r and g and b then
    r, g, b = tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)
    vim.fn.setreg("+", string.format("rgba(%d, %d, %d, 1)", r, g, b))
    print("Copied: rgba(" .. r .. ", " .. g .. ", " .. b .. ", 1)")
  else
    print("Not a valid hex color!")
  end
end

vim.keymap.set("n", "<leader>cr", HexToRGBA, { noremap = true, silent = true, desc = "Convert hex to RGBA" })

nest.applyKeymaps({

  {
    "<leader>",
    {
      { "d", "", desc = "Dap" },
      { "u", "", desc = "Undo" },
      {
        "s",
        {
          { "", "", desc = "Sort OR Noice" },
          {
            "a",
            '<cmd>!wl-paste | fold -w1 | sort | paste -sd "" | paste -sd "" | tr -d \'\\n\' | wl-copy<CR><CR>',
            silent = true,
            desc = "Sort copied by alphabet",
          },
        },
      },
    },
  },

  { "u", "k", desc = "Up" },
  { "n", "<left>", desc = "Left" },
  { "i", "<right>", desc = "Right", nowait = true },
  { "e", "j", desc = "Down" },

  { "j", "<undo>", desc = "Undo" },
  { "J", "<redo>", desc = "Redo" },

  { "w", "i", desc = "Insert" },
  { "l", "w", desc = "Forward to next word" },
  { "h", "n", desc = "Repeat latest find" },
  { "k", "e", desc = "Forward to next word end" },

  {
    "<S-",
    {
      { "u>", "<C-U>", desc = "Scroll Up" },
      { "e>", "<C-D>", desc = "Scroll Down" },
      { "w>", "I", desc = "Insert start" },
      { "l>", "W", desc = "Forward to next WORD" },
      { "n>", "^", desc = "Cursor to Begin of line" },
      { "i>", "$", desc = "Cursor to End of line" },
      { "h>", "N", desc = "Repeat latest find (opposite)" },
      { "k>", "E", desc = "Forward to next WORD end" },
    },
  },

  {
    "<C-",
    {
      { "-u>", "<C-y>", desc = "Scroll Up (line)" },
      { "-f>", "<PageUp>", desc = "Page Up" },
      { "-b>", "<PageDown>", desc = "Page Down" },
      { "-LeftMouse>", "<Nop>", desc = "Disable Left Mouse" },
    },
  },

  {
    "<C-w>",
    {
      { "n", "<C-w><left>", desc = "Window left" },
      { "i", "<C-w><right>", desc = "Window right" },
      { "e", "<C-w><down>", desc = "Window down" },
      { "u", "<C-w><up>", desc = "Window up" },
      { "N", "<C-w>H", desc = "Window left (full)" },
      { "I", "<C-w>L", desc = "Window right (full)" },
      { "E", "<C-w>J", desc = "Window down (full)" },
      { "U", "<C-w>K", desc = "Window up (full)" },
    },
  },

  {
    "<A-",
    {
      { "V>", "<cmd>vsplit<CR>", desc = "Vertical split" },
      { "B>", "<cmd>split<CR>", desc = "Horizontal split" },
      { "q>", "<cmd>bd | bp<CR>", desc = "Close buffer and previous" },
    },
  },

  {
    "g",
    {
      { "l", "ge", desc = "Backward to next word end" },
      { "L", "gE", desc = "Backward to next WORD end" },
      { "u", "gk", desc = "Move cursor up one display line" },
      { "e", "gj", desc = "Move cursor down one display line" },
    },
  },
}, {
  mode = "nxo",
  prefix = "",
  buffer = false,
  options = { noremap = true, silent = true },
})

vim.keymap.set("x", "p", [["_dP]], { noremap = true, desc = "Paste without yank" })

vim.keymap.set("n", "xx", "dd", { noremap = true, desc = "Delete line" })
