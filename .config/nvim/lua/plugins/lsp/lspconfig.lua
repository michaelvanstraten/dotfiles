return {
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		dependencies = {
			"folke/neoconf.nvim",
			"folke/neodev.nvim",
		},
		config = function()
			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						workspace = {
							checkThirdParty = false,
						},
						codeLens = {
							enable = true,
						},
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			})

			lspconfig.texlab.setup({})
			lspconfig.rust_analyzer.setup({})
		end,
	},
}
