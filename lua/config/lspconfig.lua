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

-- Rime Setup
--
local rime_ls_filetypes = { "text", "markdown", "AvanteInput" }

require('rime_ls').setup({
    filetype = rime_ls_filetypes
})
local lspconfig = require('lspconfig')
local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
lsp_capabilities = require('blink.cmp').get_lsp_capabilities(lsp_capabilities)
lspconfig.rime_ls.setup({
    init_options = {
        enabled = vim.g.rime_enabled,
        shared_data_dir = '/usr/share/rime-data',
        user_data_dir = vim.fn.expand('~/.local/share/fcitx5/rime'),
        log_dir = vim.fn.expand('~/.local/share/rime-ls'),
        always_incomplete = true, -- This is for wubi users
        long_filter_text = true
    },
    capabilities = lsp_capabilities,
    -- on_attach = rime_on_attach
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = rime_ls_filetypes,
    callback = function (env)
        local rime_ls_client = vim.lsp.get_clients({ name = 'rime_ls' })
        -- 如果没有启动 `rime-ls` 就手动启动
        if #rime_ls_client == 0 then
            vim.cmd('LspStart rime_ls')
            rime_ls_client = vim.lsp.get_clients({ name = 'rime_ls' })
        end
        -- `attach` 到 `buffer`
        if #rime_ls_client > 0 then
            vim.lsp.buf_attach_client(env.buf, rime_ls_client[1].id)
        end
    end
})
