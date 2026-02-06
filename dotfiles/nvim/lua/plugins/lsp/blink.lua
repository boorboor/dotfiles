return {
  {
    "saghen/blink.cmp",
    version = "*",
    build = "cargo +nightly build --release",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      keymap = { preset = "default" },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        list = { selection = { preselect = false, auto_insert = true } },
        ghost_text = { enabled = false },
      },
      signature = { enabled = true },
      -- Blink gets sources from lspconfig automatically, but we declare defaults:
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
  },
}
