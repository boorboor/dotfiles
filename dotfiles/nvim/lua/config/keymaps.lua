local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("n", "<leader>l", function()
  vim.opt.list = not vim.opt.list:get()
end, { desc = "Toggle Invisible Chars" })
map("n", "<BS>", "<C-^>", { desc = "Toggle Last Buffer" })
map("n", "<leader>b", "<CMD>.w !bash<CR>", { desc = "Execute line in bash", silent = true })
map("v", "<leader>b", "<CMD>'<,'>w !bash<CR>", { desc = "Execute selection in bash", silent = true })
