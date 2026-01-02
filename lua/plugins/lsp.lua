return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
    dependencies = {
      -- Plugin and UI to automatically install LSPs to stdpath
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      "hrsh7th/cmp-nvim-lsp",
      -- Install none-ls for diagnostics, code actions, and formatting
      "nvimtools/none-ls.nvim",

      -- Install neodev for better nvim configuration and plugin authoring via lsp configurations
      "folke/neodev.nvim",

      -- Progress/Status update for LSP
      { "j-hui/fidget.nvim", tag = "legacy" },
    },
    config = function()
      local map_lsp_keybinds = require("user.keymaps").map_lsp_keybinds -- Has to load keymaps before pluginslsp

      -- Use neodev to configure lua_ls in nvim directories - must load before lspconfig
      require("neodev").setup()

      -- Setup mason so it can manage 3rd party LSP servers
      require("mason").setup({
        ui = {
          border = "rounded",
        },
      })

      -- Configure mason to auto install servers
      require("mason-lspconfig").setup({
        ensure_installed = { "ruff" },
        automatic_installation = true
      })

      -- LSP servers to install (see list here: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers )
      local servers = {
        bashls = {},
        jsonls = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                library = { vim.env.VIMRUNTIME },
                checkThirdParty = false
              },
              telemetry = { enabled = false },
            },
          },
        },
        -- nil_ls = {},
        pyright = {
          settings = {
            pyright = {
              disabled = { "diagnostics" },
            },
          },
        },
        ruff = {},
        helm_ls = {
          settings = {
            ['helm-ls'] = {
              logLevel = "info",
              filetypes = {
                "helm",
                "yaml.helm"
              },

              -- Ensure values files are considered
              valuesFiles = {
                mainValuesFile = "values.yaml",
                additionalValuesFilesGlobPattern = "values*.yaml"
              },
              helmLint = {
                enabled = true,
                ignoredMessages = {},
              },
              yamlls = {
                enabled = true,
                enabledForFilesGlob = "*.{yaml,yml}",
                diagnosticsLimit = 50,
                showDiagnosticsDirectly = false,
                path = "yaml-language-server",
                initTimeoutSeconds = 3,
                config = {
                  schemas = { kubernetes = "templates/**" },
                  completion = true,
                  hover = true,
                }
              }
            }
          }
        },
        yamlls = {
          filetypes = { "yaml", "yml", "yaml.helm-values" },
          settings = {
            yaml = {
              validate = true,
              completion = true,
              hover = true,
              schemaStore = { enable = false }
            },
          }
        },
        terraformls = {},
        tflint = {},
      }

      -- nvim-cmp supports additional completion capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local default_capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      ---@diagnostic disable-next-line: unused-local
      local on_attach = function(_client, buffer_number)
        -- Pass the current buffer to map lsp keybinds
        map_lsp_keybinds(buffer_number)
      end

      -- Iterate over our servers and set them up
      for name, config in pairs(servers) do
        vim.lsp.config(name, {
          capabilities = default_capabilities,
          filetypes = config.filetypes,
          on_attach = on_attach,
          settings = config.settings
        })
      end

      -- Configure diagostics border
      vim.diagnostic.config({
        float = {
          border = "rounded",
        },
      })
    end,
  },
}
