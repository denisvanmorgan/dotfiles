-- Buffer navigation
vim.keymap.set("n", "<leader>d", "<cmd>bd<CR>", { desc = "Close buffer" })

-- Clipboard
vim.keymap.set({ "n", "x" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set({ "n", "x" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })

-- Incremental selection (built-in treesitter/LSP `an` / `in`)
vim.keymap.set("n", "<C-Space>", "van", { remap = true, desc = "Start incremental selection" })
vim.keymap.set("x", "<C-Space>", "an", { remap = true, desc = "Expand selection" })
vim.keymap.set("x", "<BS>", "in", { remap = true, desc = "Shrink selection" })
