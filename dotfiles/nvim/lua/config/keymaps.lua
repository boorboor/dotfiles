local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })

map("n", "<leader>l", function() vim.opt.list = not vim.opt.list:get() end, { desc = "Toggle Invisible Chars" })
map("n", "<BS>", "<C-^>", { desc = "Toggle Last Buffer" })

map("n", "<leader>b", "<CMD>.w !bash<CR>", { desc = "Execute line in bash", silent = true })
map("v", "<leader>b", "<CMD>'<,'>w !bash<CR>", { desc = "Execute selection in bash", silent = true })

map("n", "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
