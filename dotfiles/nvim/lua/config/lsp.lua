-- Use built-in LSP client
vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = "●",
  },
  float = {
    border = "rounded",
    source = "if_many",
    header = "",
    prefix = "",
  },
  -- Neovim 0.10+ native sign definition (replaces legacy sign_define)
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "󰠠",
    },
  },
})
