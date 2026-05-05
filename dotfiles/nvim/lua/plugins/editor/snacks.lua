return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      explorer = { replace_netrw = true },
      picker = {
        enabled = true,
        sources = {
          projects = {
            finder = "recent_projects",
            patterns = {
              "pyproject.toml",
              "Pipfile",
              "Cargo.toml",
              "package.json",
              "go.mod",
              "Makefile",
              "README.md",
              ".env",
              ".git",
            },
            dev = {
              "~/Codes/",
            },
            projects = {
              "~/.config/",
            },
            confirm = "load_session",
            win = {
              preview = { minimal = true },
              input = {
                keys = {
                  ["<c-x>"] = { "delete_projects", mode = { "n", "i" } },
                  ["<c-n>"] = { "new_project", mode = { "n", "i" } },
                },
              },
            },
          },
        },
      },
    },
    keys = {
      -- Core Pickers
      {
        "<leader>o",
        function()
          Snacks.picker.smart({ filter = { cwd = true } })
        end,
        desc = "Smart Find Files",
      },
      {
        "<leader>b",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Find Buffer",
      },
      {
        "<leader>ff",
        function()
          Snacks.picker.files()
        end,
        desc = "Find Files",
      },
      {
        "<leader>/",
        function()
          Snacks.picker.grep()
        end,
        desc = "Grep",
      },
      {
        "<leader>/w",
        function()
          Snacks.picker.grep_word()
        end,
        desc = "Visual selection or word",
        mode = { "n", "x" },
      },
      {
        "<leader>j",
        function()
          Snacks.picker.projects()
        end,
        desc = "Projects",
      },
      {
        "<leader>e",
        function()
          local pickers = Snacks.picker.get({ source = "explorer" })
          if #pickers > 0 then
            pickers[1]:focus()
          else
            Snacks.picker.explorer()
          end
        end,
        desc = "File Explorer",
      },
      {
        "<leader>,",
        function()
          Snacks.picker.resume()
        end,
        desc = "Resume Last Picker",
      },

      -- Unified UI Replacements (Replacing Trouble.nvim)
      {
        "<leader>d",
        function()
          Snacks.picker.diagnostics()
        end,
        desc = "Diagnostics Workspace",
      },
      {
        "<leader>r",
        function()
          Snacks.picker.registers()
        end,
        desc = "Registers",
      },

      -- Git & Lazygit Integration
      {
        "<leader>gl",
        function()
          Snacks.lazygit.log_file()
        end,
        desc = "Lazygit File History",
      },
      {
        "<leader>gg",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit",
      },
      {
        "<leader>gs",
        function()
          Snacks.picker.git_status()
        end,
        desc = "Git Status",
      },
      {
        "<leader>gb",
        function()
          Snacks.git.blame_line()
        end,
        desc = "Git Blame Line",
      },

      -- UI Toggles
      {
        "<esc>",
        function()
          Snacks.notifier.hide()
          pcall(vim.cmd, "nohlsearch")
        end,
        desc = "Dismiss Notifications & Clear hlsearch",
        mode = "n",
        expr = true,
      },
      {
        "<leader>td",
        function()
          Snacks.toggle.diagnostics():toggle()
        end,
        desc = "Toggle Diagnostics",
      },
      {
        "<leader>ti",
        function()
          Snacks.toggle.inlay_hints():toggle()
        end,
        desc = "Toggle Inlay Hints",
      },
      {
        "<leader>n",
        function()
          Snacks.picker.notifications()
        end,
        desc = "Notification Logs",
      },
    },
  },
}
