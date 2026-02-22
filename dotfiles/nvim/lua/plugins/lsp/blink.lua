return {
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "zbirenbaum/copilot.lua",
      "giuxtaposition/blink-cmp-copilot",
    },
    opts = {
      keymap = {
        preset = "none", -- Disable default to avoid conflicts
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide" },
        ["<CR>"] = { "accept", "fallback" },

        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },

        ["<C-n>"] = { "scroll_documentation_up", "fallback" },
        ["<C-p>"] = { "scroll_documentation_down", "fallback" },
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        list = { selection = { preselect = false, auto_insert = false } },
        ghost_text = { enabled = true },
      },
      signature = { enabled = true },
      sources = {
        default = { "lsp", "path", "snippets", "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            score_offset = 10,
            async = true,
          },
        },
      },
    },
  },
}
