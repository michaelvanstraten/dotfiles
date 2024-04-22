return {
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		opts = {},
	},
	{
		"echasnovski/mini.ai",
		event = "VeryLazy",
		opts = function()
			local ai = require("mini.ai")

			return {
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}, {}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
					g = function() -- Whole buffer, similar to `gg` and 'G' motion
						local from = { line = 1, col = 1 }
						local to = {
							line = vim.fn.line("$"),
							col = math.max(vim.fn.getline("$"):len(), 1),
						}
						return { from = from, to = to }
					end,
					["$"] = ai.gen_spec.pair("$", "$", { type = "greedy" }),
				},
			}
		end,
	},
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			local pairs = require("mini.pairs")

			-- vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
			-- 	pattern = { "*.rs" },
			-- 	callback = function(autocmd)
			-- 		print(autocmd.buf)
			-- 		autocmd.
			-- 		pairs.unmap_buf(autocmd.buf, "i", "'", "''")
			-- 	end,
			-- })
			--
			pairs.setup(opts)
		end,
	},
	{
		"echasnovski/mini.surround",
		event = "VeryLazy",
		opts = {
			mappings = {
				add = "sa",
				delete = "sd",
				find = "sf",
				find_left = "sF",
				highlight = "sh",
				replace = "sr",
				update_n_lines = "sn",
			},
		},
	},
}
