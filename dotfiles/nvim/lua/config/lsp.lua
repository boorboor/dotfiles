-- Use built-in LSP client
vim.diagnostic.config({
  virtual_text = { prefix = "●" },
  float = { border = "rounded" },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
