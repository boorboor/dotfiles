return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          dismiss = "<C-c>",
          accept = "<C-l>",
          prev = "<C-p>",
          next = "<C-n>",
        },
      },
      panel = { enabled = true },
    },
  },
}
