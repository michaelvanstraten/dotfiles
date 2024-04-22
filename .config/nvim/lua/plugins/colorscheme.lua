return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	lazy = false,
	opts = {
		flavour = "mocha",
		transparent_background = true,
		integrations = {
			cmp = true,
			gitsigns = true,
			markdown = true,
			mason = true,
			mini = true,
			neotree = true,
			noice = true,
			nvimtree = true,
			semantic_tokens = true,
			telescope = true,
			treesitter = true,
		},
		custom_highlights = function(colors)
			return {
				Comment = { fg = colors.flamingo },
				TabLineSel = { bg = colors.pink },
				CmpBorder = { fg = colors.surface2 },
				Pmenu = { bg = colors.none },
			}
		end,
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd.colorscheme("catppuccin")
	end,
}
