local lsp = require("lsp-zero")
local handlers = {
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	-- function(server_name) -- default handler (optional)
	-- 	require("lspconfig")[server_name].setup({})
	-- end,
	lsp.default_setup,
	-- Next, you can provide targeted overrides for specific servers.
	["lua_ls"] = function()
		local lspconfig = require("lspconfig")
		lspconfig.lua_ls.setup({
			settings = {
				Lua = {
					diagnostics = {
						-- disable = { "undefined-field" },
						globals = { "vim" },
					},
				},
			},
		})
	end,
}

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"clangd",
		"lua_ls",
		"jqls",
		"gopls",
		"html",
		"bashls",
		"jqls",
		"eslint",
		"pyright",
		"ts_ls",
		"jsonls",
		"volar",
	},
	automatic_installation = { exclude = {} },
	handlers = handlers,
})

require("lspconfig").eslint.setup({})

require("mason-tool-installer").setup({

	-- a list of all tools you want to ensure are installed upon
	ensure_installed = {

		-- you can pin a tool to a particular version
		{ "golangci-lint", version = "v1.47.0" },

		-- you can turn off/on auto_update per tool
		{ "bash-language-server", auto_update = true },

		--'lua-language-server',
		"vim-language-server",
		"gopls",
		"clang-format",
		"stylua",
		"prettierd",
		"prettier",
		"black",
		"isort",
		"shellcheck",
		"gofumpt",
		"golines",
		"gomodifytags",
		"gotests",
		"impl",
		"jq",
		"misspell",
		"revive",
		"shellcheck",
		"shfmt",
		"staticcheck",
		"vint",
	},
})

local dap = require("dap")
dap.configurations.lua = {
	{
		type = "nlua",
		request = "attach",
		name = "Attach to running Neovim instance",
	},
}

dap.adapters.nlua = function(callback, config)
	callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
end

vim.keymap.set("n", "<leader>db", require("dap").toggle_breakpoint, { noremap = true })
vim.keymap.set("n", "<leader>dc", require("dap").continue, { noremap = true })
vim.keymap.set("n", "<leader>do", require("dap").step_over, { noremap = true })
vim.keymap.set("n", "<leader>di", require("dap").step_into, { noremap = true })

vim.keymap.set("n", "<leader>dl", function()
	require("osv").launch({ port = 8086 })
end, { noremap = true })

vim.keymap.set("n", "<leader>dw", function()
	local widgets = require("dap.ui.widgets")
	widgets.hover()
end)

vim.keymap.set("n", "<leader>df", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.frames)
end)
