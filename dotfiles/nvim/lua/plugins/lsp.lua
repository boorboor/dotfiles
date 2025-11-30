return {
  {
    "b0o/schemastore.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "saghen/blink.cmp",
    },
    config = function()
      local api = vim.api
      local lsp = vim.lsp

      vim.diagnostic.config({
        virtual_text = { prefix = "●" },
        float = { border = "rounded" },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "✘",
            [vim.diagnostic.severity.WARN] = "▲",
            [vim.diagnostic.severity.HINT] = "⚑",
            [vim.diagnostic.severity.INFO] = "»",
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      local function get_capabilities()
        local caps = lsp.protocol.make_client_capabilities()
        caps.general = vim.tbl_deep_extend("force", caps.general or {}, {
          positionEncodings = { "utf-16" },
        })
        local has_blink, blink = pcall(require, "blink.cmp")
        if has_blink then
          return blink.get_lsp_capabilities(caps)
        end
        return caps
      end

      api.nvim_create_autocmd("LspAttach", {
        group = api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(ev)
          local client = lsp.get_client_by_id(ev.data.client_id)
          local function map(mode, keys, func, desc)
            vim.keymap.set(mode, keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
          end

          map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
          map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
          map("n", "gr", vim.lsp.buf.references, "Goto References")
          map("n", "gi", vim.lsp.buf.implementation, "Goto Implementation")
          map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
          map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
          map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
          map("n", "<leader>cf", function()
            vim.lsp.buf.format({ async = true })
          end, "Format File")

          if client and client.server_capabilities.documentHighlightProvider then
            local group = api.nvim_create_augroup("LspDocumentHighlight", { clear = false })
            api.nvim_clear_autocmds({ group = group, buffer = ev.buf })
            api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = ev.buf,
              group = group,
              callback = vim.lsp.buf.document_highlight,
            })
            api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = ev.buf,
              group = group,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      local servers = {
        basedpyright = {
          filetypes = { "python" },
          cmd = { "basedpyright-langserver", "--stdio" },
          root_markers = { "pyproject.toml", "setup.py", ".git" },
          settings = {
            basedpyright = {
              disableOrganizeImports = true,
              analysis = { typeCheckingMode = "standard", autoSearchPaths = true },
            },
          },
        },
        ruff = {
          filetypes = { "python" },
          cmd = { "ruff", "server" },
          root_markers = { "pyproject.toml", "ruff.toml", ".git" },
        },
        ts_ls = {
          filetypes = { "javascript", "typescript", "typescriptreact" },
          cmd = { "typescript-language-server", "--stdio" },
          root_markers = { "package.json", "tsconfig.json", ".git" },
          init_options = { hostInfo = "neovim" },
        },
        rust_analyzer = {
          filetypes = { "rust" },
          cmd = { "rust-analyzer" },
          root_markers = { "Cargo.toml" },
        },
        jsonls = {
          filetypes = { "json", "jsonc" },
          cmd = { "vscode-json-languageserver", "--stdio" },
          root_markers = { ".git" },
          settings = {
            json = {
              validate = { enable = true },
              schemas = require("schemastore").json.schemas(),
            },
          },
        },
        gremlh = {
          filetypes = { "text", "jsonc", "json", "yaml", "toml", "markdown", "python", "rust" },
          cmd = { "gremlh-lsp" },
          root_markers = { ".git" },
          condition = function(cmd)
            if vim.fn.executable(cmd[1]) == 1 then
              return true
            end

            local dev_path = "/Users/dev/Codes/gremlh/target/debug/gremlh-lsp"
            if vim.fn.executable(dev_path) == 1 then
              cmd[1] = dev_path
              return true
            end
            return false
          end,
        },
      }

      for name, config in pairs(servers) do
        if config.condition and not config.condition(config.cmd) then
          goto continue
        end

        api.nvim_create_autocmd("FileType", {
          pattern = config.filetypes,
          group = api.nvim_create_augroup("LspStart_" .. name, { clear = true }),
          callback = function(args)
            if vim.fn.executable(config.cmd[1]) == 0 then
              return
            end

            local root = vim.fs.root(args.buf, config.root_markers)
            if root then
              lsp.start({
                name = name,
                cmd = config.cmd,
                root_dir = root,
                settings = config.settings,
                init_options = config.init_options,
                capabilities = get_capabilities(),
              })
            end
          end,
        })

        ::continue::
      end
    end,
  },
}
