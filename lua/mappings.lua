-- =============================================================================
-- 1. Helper Functions & Basic Settings
-- =============================================================================

local function HexToRGBA()
  local hex = vim.fn.expand("<cword>")
  local r, g, b = hex:match("#?(%x%x)(%x%x)(%x%x)")
  if r and g and b then
    r, g, b = tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)
    vim.fn.setreg("+", string.format("rgba(%d, %d, %d, 1)", r, g, b))
    print("Copied: rgba(" .. r .. ", " .. b .. ", " .. b .. ", 1)")
  else
    print("Not a valid hex color!")
  end
end

-- Delete specific default/plugin mapping
vim.keymap.del("x", "in")

-- Custom Command Mappings
vim.keymap.set("n", "<leader>cr", HexToRGBA, { noremap = true, silent = true, desc = "Convert hex to RGBA" })
vim.keymap.set("n", "<C-W><C-N>", "", { noremap = true })

-- Define shared modes and options to keep code DRY (Don't Repeat Yourself)
local modes = { "n", "x", "o" }
local opts = { noremap = true, silent = true }

-- =============================================================================
-- 2. Converted Nest Mappings (Native)
-- =============================================================================

-- Leader mappings
vim.keymap.set("n", "<leader>d", "", { desc = "Dap" })
vim.keymap.set("n", "<leader>u", "", { desc = "Undo" })
vim.keymap.set("n", "<leader>s", "", { desc = "Sort OR Noice" })
vim.keymap.set("n", "<leader>sa", '<cmd>!wl-paste | fold -w1 | sort | paste -sd "" | paste -sd "" | tr -d \'\\n\' | wl-copy<CR><CR>', 
    { silent = true, desc = "Sort copied by alphabet" })

-- Core Navigation (Colemak HNEI-style logic)
vim.keymap.set(modes, "u", "k", { desc = "Up", noremap = true, silent = true })
vim.keymap.set(modes, "n", "<left>", { desc = "Left", noremap = true, silent = true })
vim.keymap.set(modes, "i", "<right>", { desc = "Right", nowait = true, noremap = true, silent = true })
vim.keymap.set(modes, "e", "j", { desc = "Down", noremap = true, silent = true })

-- Undo / Redo (Mapping j to standard u/redo)
vim.keymap.set(modes, "j", "u", { desc = "Undo", noremap = true, silent = true })
vim.keymap.set(modes, "J", "<C-r>", { desc = "Redo", noremap = true, silent = true })

-- Text Objects & Search
vim.keymap.set(modes, "w", "i", { desc = "Insert", noremap = true, silent = true })
vim.keymap.set(modes, "l", "w", { desc = "Forward to next word", noremap = true, silent = true })
vim.keymap.set(modes, "h", "n", { desc = "Repeat latest find", noremap = true, silent = true })
vim.keymap.set(modes, "k", "e", { desc = "Forward to next word end", noremap = true, silent = true })

-- Shift (S-) Combinations / Uppercase
vim.keymap.set(modes, "U", "<C-u>", { desc = "Scroll Up", noremap = true, silent = true })
vim.keymap.set(modes, "E", "<C-d>", { desc = "Scroll Down", noremap = true, silent = true })
vim.keymap.set(modes, "W", "I", { desc = "Insert start", noremap = true, silent = true })
vim.keymap.set(modes, "L", "W", { desc = "Forward to next WORD", noremap = true, silent = true })
vim.keymap.set(modes, "N", "^", { desc = "Cursor to Begin of line", noremap = true, silent = true })
vim.keymap.set(modes, "I", "$", { desc = "Cursor to End of line", noremap = true, silent = true })
vim.keymap.set(modes, "H", "N", { desc = "Repeat latest find (opposite)", noremap = true, silent = true })
vim.keymap.set(modes, "K", "E", { desc = "Forward to next WORD end", noremap = true, silent = true })

-- Control (C-) Combinations
vim.keymap.set(modes, "<C-u>", "<C-y>", { desc = "Scroll Up (line)", noremap = true, silent = true })
vim.keymap.set(modes, "<C-f>", "<PageUp>", { desc = "Page Up", noremap = true, silent = true })
vim.keymap.set(modes, "<C-b>", "<PageDown>", { desc = "Page Down", noremap = true, silent = true })
vim.keymap.set(modes, "<C-LeftMouse>", "<Nop>", { desc = "Disable Left Mouse", noremap = true, silent = true })

-- Window Management (C-w prefix)
vim.keymap.set(modes, "<C-w>n", "<C-w><left>", { desc = "Window left", noremap = true, silent = true })
vim.keymap.set(modes, "<C-w>i", "<C-w><right>", { desc = "Window right", noremap = true, silent = true })
vim.keymap.set(modes, "<C-w>e", "<C-w><down>", { desc = "Window down", noremap = true, silent = true })
vim.keymap.set(modes, "<C-w>u", "<C-w><up>", { desc = "Window up", noremap = true, silent = true })
vim.keymap.set(modes, "<C-w>N", "<C-w>H", { desc = "Window left (full)", noremap = true, silent = true })
vim.keymap.set(modes, "<C-w>I", "<C-w>L", { desc = "Window right (full)", noremap = true, silent = true })
vim.keymap.set(modes, "<C-w>E", "<C-w>J", { desc = "Window down (full)", noremap = true, silent = true })
vim.keymap.set(modes, "<C-w>U", "<C-w>K", { desc = "Window up (full)", noremap = true, silent = true })

-- Alt (A-) Combinations
vim.keymap.set(modes, "<A-v>", "<cmd>vsplit<CR>", { desc = "Vertical split", noremap = true, silent = true })
vim.keymap.set(modes, "<A-b>", "<cmd>split<CR>", { desc = "Horizontal split", noremap = true, silent = true })
vim.keymap.set(modes, "<A-q>", "<cmd>bd | bp<CR>", { desc = "Close buffer and previous", noremap = true, silent = true })

-- 'g' prefix mappings
vim.keymap.set(modes, "gl", "ge", { desc = "Backward to next word end", noremap = true, silent = true })
vim.keymap.set(modes, "gL", "gE", { desc = "Backward to next WORD end", noremap = true, silent = true })

-- =============================================================================
-- 3. Standalone Final Mappings
-- =============================================================================

-- Visual mode paste without overwriting register
vim.keymap.set("x", "p", [["_dP]], { noremap = true, desc = "Paste without yank" })

-- LSP / Telescope
vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { noremap = true, desc = "Show Definitions" })
