local api = vim.api

api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
  group = api.nvim_create_augroup("GhosttyDirSync", { clear = true }),
  callback = function()
    if vim.env.GHOSTTY_RESOURCES_DIR then
      local osc7 = string.format("\27]7;file://localhost%s\27\\", vim.uv.cwd())
      vim.fn.chansend(vim.v.stderr, osc7)
    end
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  callback = function(ev)
    local function map(mode, keys, func, desc)
      vim.keymap.set(mode, keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
    end

    -- Standard Navigation
    map("n", "gd", function()
      Snacks.picker.lsp_definitions()
    end, "Goto Definition")
    map("n", "gr", function()
      Snacks.picker.lsp_references()
    end, "Goto References")
    map("n", "gI", function()
      Snacks.picker.lsp_implementations()
    end, "Goto Implementation")
    map("n", "gy", function()
      Snacks.picker.lsp_type_definitions()
    end, "Goto Type Definition")

    -- Structural Discovery
    map("n", "<leader>ss", function()
      Snacks.picker.lsp_workspace_symbols()
    end, "LSP Workspace Symbols")

    -- Actions
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
    map("n", "<leader>cr", vim.lsp.buf.rename, "Rename Symbol")
  end,
})
