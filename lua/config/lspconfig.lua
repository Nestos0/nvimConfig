local lspconfig = require("lspconfig")
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

require("mason").setup({
	ensure_installed = { "hadolint", "eslint_d" },
})
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
		"dockerls",
		"docker_compose_language_service",
        "nginx_language_server",
        "eslint"
	},
	automatic_installation = { exclude = {} },
	handlers = handlers,
})

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

