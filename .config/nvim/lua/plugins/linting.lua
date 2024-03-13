return {
	"mfussenegger/nvim-lint",
	opts = {
		linters_by_ft = {
			fish = { "fish" },
			sh = { "shellcheck" },
			dockerfile = { "hadolint" },
		},
	},
}
