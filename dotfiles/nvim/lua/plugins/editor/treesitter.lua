return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "python",
        "rust",
        "javascript",
        "typescript",
        "markdown",
        "yaml",
        "json",
        "vimdoc",
        "c",
        "query",
      },
      sync_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}
