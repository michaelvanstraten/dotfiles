return {
	{
		"stevearc/conform.nvim",
		lazy = true,
		cmd = "ConformInfo",
		keys = {
			{
				"<leader>fm",
				function()
					require("conform").format()
				end,
				mode = { "n" },
				desc = "Format the buffer",
			},
		},
		opts = function()
			return {
				formatters_by_ft = {
					lua = { "stylua" },
					fish = { "fish_indent" },
					sh = { "shfmt" },
					python = { "black" },
					tex = { "latexindent" },
				},
				formatters = {
					latexindent = {
						args = { "-m", "-l", "-" },
						cwd = require("conform.util").root_file({ ".latexindent.yaml" }),
					},
				},
			}
		end,
	},
}
