local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

opt.cursorline = true
opt.scrolloff = 10
opt.termguicolors = true

opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split"

-- opt.clipboard = "unnamedplus"
opt.updatetime = 250
opt.timeoutlen = 300

opt.swapfile = false
opt.backup = false
opt.undofile = true
local undo_dir = vim.fn.stdpath("state") .. "/undo"
if not vim.fn.isdirectory(undo_dir) then
  vim.fn.mkdir(undo_dir, "p")
end
opt.undodir = undo_dir

opt.splitright = true
opt.splitbelow = true

opt.list = false
opt.listchars = {
  eol = "⏎",
  tab = "  ┊",
  trail = "•",
  extends = "…",
  precedes = "…",
  space = " ",
}

opt.shortmess:append("sI")
opt.laststatus = 3
