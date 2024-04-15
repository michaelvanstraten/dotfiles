local map = vim.keymap.set

-- Press jk to exit insert mode
map("i", "jk", "<ESC>", { desc = "Escape insert mode" })
map("i", "kj", "<ESC>", { desc = "Escape insert mode" })

-- Disable recording of macros
map({ "n" }, "q", "<nop>", { desc = "does nothing to disable recording" })

-- lazygit
-- map("n", "<leader>g", function()
-- 	util.terminal({ "lazygit" }, { cwd = util.root(), esc_esc = false, ctrl_hjkl = false })
-- end, { desc = "Lazygit (root dir)" })
-- map("n", "<leader>G", function()
-- 	util.terminal({ "lazygit" }, { esc_esc = false, ctrl_hjkl = false })
-- end, { desc = "Lazygit (cwd)" })

-- Move Lines
map("n", "J", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "K", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Format files
-- map({ "n", "v" }, "<leader>fm", function()
-- 	util.format({ force = true })
-- end, { desc = "Format" })
