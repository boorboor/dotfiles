return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("AutoRestoreSession", { clear = true }),
        nested = true,
        callback = function()
          if vim.fn.argc() == 0 and not vim.g.started_with_stdin then
            vim.schedule(function()
              if vim.bo.filetype == "lazy" then
                vim.api.nvim_create_autocmd("WinClosed", {
                  pattern = tostring(vim.api.nvim_get_current_win()),
                  once = true,
                  callback = function()
                    require("persistence").load({ last = true })
                  end,
                })
              else
                require("persistence").load({ last = true })
              end
            end)
          end
        end,
      })
    end,
  },
}
