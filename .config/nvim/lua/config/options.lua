local g = vim.g
local opt = vim.opt

-- Use latex format for `.tex` files
g.tex_flavor = "latex"

-- Indenting
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4

-- Numbers
opt.relativenumber = true

-- Disable swap file
opt.swapfile = false

-- Hide status line
-- opt.laststatus = 0

-- Enable smart wrapping
opt.wrap = false
opt.breakindent = false

-- Disable indent guide
opt.list = false

-- Enable spell checking
opt.spelllang = {
	"en",
	"de",
}
opt.spell = true

-- Match keywords with hyphen
opt.iskeyword:append("-")
