return {
  {
    "mason-lspconfig.nvim",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = { "vtsls", "eslint", "cssmodules_ls" },
    },
  },
  {
    "nvim-treesitter",
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
    "mason.nvim",
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = { "js-debug-adapter" } },
  },
  -- {
  --   "conform.nvim",
  --   opts = {
  --     formatters_by_ft = {
  --       typescript = { "prettier", lsp_format = "last" },
  --       typescriptreact = { "prettier", lsp_format = "last" },
  --     },
  --   },
  -- },
  {
    "nvim-dap",
    opts = function()
      local dap = require "dap"

      -- ref: https://github.com/StevanFreeborn/nvim-config/blob/main/lua/plugins/debugging.lua
      for _, adapterType in ipairs { "node", "chrome", "msedge" } do
        local pwaType = "pwa-" .. adapterType

        dap.adapters[pwaType] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            args = {
              vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
              "${port}",
            },
          },
        }

        -- this allow us to handle launch.json configurations
        -- which specify type as "node" or "chrome" or "msedge"
        dap.adapters[adapterType] = function(cb, config)
          local nativeAdapter = dap.adapters[pwaType]

          config.type = pwaType

          if type(nativeAdapter) == "function" then
            nativeAdapter(cb, config)
          else
            cb(nativeAdapter)
          end
        end
      end

      local enter_launch_url = function()
        local co = coroutine.running()
        return coroutine.create(function()
          vim.ui.input({ prompt = "Enter URL: ", default = "http://localhost:" }, function(url)
            if url == nil or url == "" then
              return
            else
              coroutine.resume(co, url)
            end
          end)
        end)
      end

      for _, language in ipairs { "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" } do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file using Node.js (nvim-dap)",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach to process using Node.js (nvim-dap)",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
          -- requires ts-node to be installed globally or locally
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file using Node.js with ts-node/register (nvim-dap)",
            program = "${file}",
            cwd = "${workspaceFolder}",
            runtimeArgs = { "-r", "ts-node/register" },
          },
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Launch Chrome (nvim-dap)",
            url = enter_launch_url,
            webRoot = "${workspaceFolder}",
            sourceMaps = true,
          },
          {
            type = "pwa-msedge",
            request = "launch",
            name = "Launch Edge (nvim-dap)",
            url = enter_launch_url,
            webRoot = "${workspaceFolder}",
            sourceMaps = true,
          },
        }
      end
    end,
  },

  -- Other extensions
  {
    "dmmulroy/ts-error-translator.nvim",
    ft = { "typescript", "typescriptreact" },
  },
  {
    "vuki656/package-info.nvim",
    lazy = true,
    init = function()
      vim.api.nvim_create_autocmd("BufRead", {
        group = vim.api.nvim_create_augroup("package_json_cmd", { clear = true }),
        pattern = "*/package.json",
        callback = function()
          require("which-key").add {
            { "<leader>m", group = "Package.json" },
            { "<leader>mt", "<cmd>lua require('package-info').toggle()<cr>", desc = "Toggle", buffer = true },
            { "<leader>mu", "<cmd>lua require('package-info').update()<cr>", desc = "Update", buffer = true },
            { "<leader>md", "<cmd>lua require('package-info').delete()<cr>", desc = "Delete", buffer = true },
            { "<leader>mi", "<cmd>lua require('package-info').install()<cr>", desc = "Install", buffer = true },
            { "<leader>mc", "<cmd>lua require('package-info').change_version()<cr>", desc = "Change", buffer = true },
          }
        end,
      })
    end,
    opts = {
      -- Check `:help nvim_set_hl()` for more attributes.
      highlights = {
        up_to_date = { -- highlight for up to date dependency virtual text
          fg = "#3C4048",
        },
        outdated = { -- highlight for outdated dependency virtual text
          fg = "#d19a66",
        },
        invalid = { -- highlight for invalid dependency virtual text
          fg = "#ee4b2b",
        },
      },
      icons = {
        enable = true, -- Whether to display icons
        style = {
          up_to_date = "|  ", -- Icon for up to date dependencies
          outdated = "|  ", -- Icon for outdated dependencies
          invalid = "|  ", -- Icon for invalid dependencies
        },
      },
      notifications = true, -- Whether to display notifications when running commands
      autostart = false, -- Whether to autostart when `package.json` is opened
      hide_up_to_date = false, -- It hides up to date versions when displaying virtual text
      hide_unstable_versions = false, -- It hides unstable versions from version list e.g next-11.1.3-canary3
      -- Can be `npm`, `yarn`, or `pnpm`. Used for `delete`, `install` etc...
      -- The plugin will try to auto-detect the package manager based on
      -- `yarn.lock` or `package-lock.json`. If none are found it will use the
      -- provided one, if nothing is provided it will use `yarn`
      package_manager = "pnpm",
    },
  },
}
