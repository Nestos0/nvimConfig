local handlers = {
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup({})
	end,
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
	ensure_installed = { "lua_ls" },
	automatic_installation = { exclude = { "lua_ls" } },
	handlers = handlers,
})
