return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ts_ls = {
          enabled = false,
        },
        vtsls = {
          enabled = vim.g.vue_version == nil,
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
          },
          settings = {
            complete_function_calls = true,
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                maxInlayHintLength = 30,
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
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
        },
        eslint = {},
        cssmodules_ls = {},
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {
        "jsdoc",
        "javascript",
        "typescript",
        "tsx",
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = { "js-debug-adapter" } },
  },
  {
    "dmmulroy/ts-error-translator.nvim",
    ft = { "typescript", "typescriptreact" },
  },
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require "dap"
      local installation_path = vim.fn.stdpath "data" .. "/mason/packages"

      dap.adapters["pwa-node"] = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = "node",
          args = { installation_path .. "/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" },
        },
      }

      dap.configurations.javascript = {
        {
          name = "Launch",
          type = "pwa-node",
          request = "launch",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
      }
      -- https://github.com/mfussenegger/nvim-dap/discussions/659
      dap.configurations.typescript = {
        {
          name = "Launch",
          type = "pwa-node",
          request = "launch",
          program = "${file}",
          cwd = "${workspaceFolder}",
          runtimeArgs = { "-r", "ts-node/register" },
          runtimeExecutable = "node",
        },
      }
    end,
  },
}
