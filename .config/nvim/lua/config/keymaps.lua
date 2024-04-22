local map = vim.keymap.set

-- Press jk to exit insert mode
map("i", "jk", "<ESC>", { desc = "Escape insert mode" })
map("i", "kj", "<ESC>", { desc = "Escape insert mode" })

-- Disable recording of macros
map({ "n" }, "q", "<nop>", { desc = "does nothing to disable recording" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move line Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move line Up" })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
