Lazy = {}
local sqlite_path = os.getenv("HOME") .. "/.guix-home/profile/lib/libsqlite3.so"

if vim.fn.filereadable(sqlite_path) == 1 then
    vim.g.sqlite_clib_path = sqlite_path
end
require("cformat")
require("lspc")
require("config.lazy")
require("config.colorscheme")
require("autocmds")
require("options")
require("mappings")
