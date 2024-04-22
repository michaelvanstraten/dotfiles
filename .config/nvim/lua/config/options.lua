local g = vim.g

-- Global Settings
g.tex_flavor = "latex"
g.mapleader = " "
g.maplocalleader = "\\"

local opt = vim.opt

-- Indentation
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4

-- Display
opt.signcolumn = "yes"
opt.number = true
opt.relativenumber = true
opt.pumblend = 10
opt.termguicolors = true
opt.fillchars = {
  eob = " ",
}

-- Mouse
opt.mouse = "a"

-- File Handling
opt.undofile = true
opt.swapfile = false

-- Wrapping and Formatting
opt.wrap = true
opt.breakindent = false

-- Spell Checking
opt.spelllang = { "en", "de" }
opt.spell = true

-- Additional Settings
if vim.fn.has("nvim-0.10") == 1 then
	opt.smoothscroll = true
end

-- Keyword Matching
opt.iskeyword:append("-")
