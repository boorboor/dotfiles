return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "PersistenceLoadPre",
        callback = function()
          local bufs = vim.api.nvim_list_bufs()
          for _, buf in ipairs(bufs) do
            if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
              if vim.bo[buf].modified then
                -- Prefix with 'confirm' to trigger the native save prompt instead of throwing E89
                vim.cmd(string.format("silent! confirm bdelete %d", buf))
              else
                vim.api.nvim_buf_delete(buf, { force = false })
              end
            end
          end
        end,
      })

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
