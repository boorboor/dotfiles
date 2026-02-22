return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    opts = {
      suggestion = {
        enabled = false,
        auto_trigger = true,
        keymap = {
          dismiss = "<C-c>",
          accept = "<C-f>",
          prev = "<C-p>",
          next = "<C-n>",
        },
      },
      panel = { enabled = true },
    },
  },
}
