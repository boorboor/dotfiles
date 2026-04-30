return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
        component_separators = "|",
        section_separators = "",
      },
      sections = {
        lualine_b = {
          {
            function()
              return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
            end,
            icon = "󰉖",
          },
          "branch",
          "diff",
          "diagnostics",
        },
        lualine_c = {
          {
            "filename",
            path = 1,
          },
        },
      },
    },
  },
}
