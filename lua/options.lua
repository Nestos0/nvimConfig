local opt = vim.opt
local o = vim.o
local g = vim.g
local wo = vim.wo
local api = vim.api

-------------------------------------- options ------------------------------------------
o.showmode = false

wo.scroll = 15

o.completeopt = 'menu,menuone,preview'
o.clipboard = "unnamed"
o.cursorline = true
o.cursorlineopt = "number"

-- Indenting
o.expandtab = true
o.autoindent = true
o.smartindent = true
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2

opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

o.formatoptions = "o"
-- Numbers
o.number = true
o.numberwidth = 1
o.ruler = false

-- disable nvim intro
opt.shortmess:append("sI")
opt.shortmess:remove("l")

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400


-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>hl")

-- disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has("win32") ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath("data"), "mason", "bin" }, sep) .. delim .. vim.env.PATH

api.nvim_create_autocmd("BufRead", {
  pattern = { "docker-compose*.yml", "docker-compose*.yaml", "compose*.yml", "compose*.yaml" },
  callback = function()
    vim.bo.filetype = "yaml.docker-compose"
  end,
})

o.conceallevel = 2 -- Hide * markup for bold and italic
o.confirm = true -- Confirm to save changes before exiting modified buffer
o.cursorline = true -- Enable highlighting of the current line

opt.list = true -- Show some invisible characters (tabs...
opt.pumblend = 0 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.showmode = false -- We have a status line and modicator
opt.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { 'en' }
opt.termguicolors = true -- True color support
opt.undofile = true
opt.swapfile = false        -- 禁用交换文件
opt.backup = false          -- 禁用备份文件
opt.writebackup = false     -- 禁用写入备份
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.virtualedit = 'block' -- Allow cursor to move where there is no text in visual block mode
opt.wrap = false -- Line wrapping

-- don't show the neovim dashboard
opt.shortmess:append('I')

-- -- statusline
-- opt.cmdheight = 0
-- opt.laststatus = 3
-- local str = string.rep('-', api.nvim_win_get_width(0))
-- opt.statusline = str

-- Default splitting will cause your main splits to jump when opening an edgebar.
-- To prevent this, set `splitkeep` to either `screen` or `topline`.
opt.splitkeep = 'screen'
opt.foldcolumn = "0"

opt.list = true
opt.listchars:append('space:⋅')
opt.listchars:append('trail:⋅')
opt.fillchars = {
	fold = ' ', -- or "⸱"
	foldopen = '',
	foldclose = '',
	foldsep = ' ',
	diff = '╱',
	eob = ' ',

	vert = ' ',
}

opt.mousemoveevent = true

-- Support for semantic higlighting https://github.com/neovim/neovim/pull/21100
-- g.lsp_semantic_enabled = 1

if g.neovide then
	opt.linespace = 4
	g.neovide_scale_factor = 1.0
	g.neovide_refresh_rate = 288
	g.neovide_cursor_trail_size = 0.1
	g.neovide_cursor_animation_length = 0.05
	g.neovide_scroll_animation_length = 0.1 -- 0.1 to enable, 0 to disable
	-- https://github.com/neovide/neovide/issues/1325#issuecomment-1281570219
	-- g.neovide_font_hinting = 'none'
	-- g.neovide_font_edging = 'subpixelantialias'
end

vim.diagnostic.config({
  signs = {
    active = true, -- 启用诊断标记
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "󰌵",
    },
  },

  underline = true,
  virtual_text = {
    prefix = "", -- 可以自定义前缀
  },
  update_in_insert = false,
})


