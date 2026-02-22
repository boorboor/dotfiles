return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = true,
      styles = {
        floats = "transparent", -- Fixes LSP hover windows & Snacks picker
      },
      on_highlights = function(hl, c)
        hl.GitSignsChange = { fg = c.orange }
        hl.SnacksIndent = { fg = c.bg_highlight }
        hl.SnacksIndentScope = { fg = c.dark3 }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },
}
