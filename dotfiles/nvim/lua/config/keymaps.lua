local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("n", "<leader>l", function()
  vim.opt.list = not vim.opt.list:get()
end, { desc = "Toggle Invisible Chars" })
