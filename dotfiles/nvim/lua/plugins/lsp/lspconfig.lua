return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "saghen/blink.cmp",
      "b0o/schemastore.nvim",
    },
    config = function()
      require("lspconfig")
      local blink = require("blink.cmp")

      local capabilities = blink.get_lsp_capabilities()

      -- Neovim 0.11 native LSP integration
      local function enable_lsp(server, opts)
        opts = opts or {}
        opts.capabilities = vim.tbl_deep_extend("force", opts.capabilities or {}, capabilities)

        -- Override nvim-lspconfig defaults dynamically
        vim.lsp.config[server] = vim.tbl_deep_extend("force", vim.lsp.config[server] or {}, opts)
        vim.lsp.enable(server)
      end

      enable_lsp("basedpyright", {
        settings = {
          basedpyright = {
            disableOrganizeImports = true,
            analysis = {
              typeCheckingMode = "standard",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "openFilesOnly",
              autoImportCompletions = false,
            },
          },
        },
      })

      enable_lsp("ruff", {
        on_attach = function(client, _)
          client.server_capabilities.hoverProvider = false
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      })

      enable_lsp("vtsls", {
        on_attach = function(client, _)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
        settings = {
          typescript = {
            inlayHints = {
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              enumMemberValues = { enabled = true },
            },
          },
        },
      })

      enable_lsp("eslint", {
        on_attach = function(client, _)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      })

      enable_lsp("rust_analyzer", {
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = { command = "clippy" },
          },
        },
      })

      enable_lsp("jsonls", {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })

      enable_lsp("yamlls", {
        settings = {
          yaml = {
            schemaStore = { enable = false, url = "" },
            schemas = require("schemastore").yaml.schemas(),
          },
        },
      })

      enable_lsp("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })
      enable_lsp("dockerls")
      enable_lsp("marksman")
    end,
  },
}
