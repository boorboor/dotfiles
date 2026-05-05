vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>l", function()
  vim.opt.list = not vim.opt.list:get()
end, { desc = "Toggle Invisible Chars" })
