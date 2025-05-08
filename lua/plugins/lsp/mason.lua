local icons = require "utils.icons"

return {
  {
    "mason-org/mason.nvim",
    version = "^1.11.0",
    cmd = "Mason",
    init = function()
      require("utils").add_ui_ft "mason"
    end,
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {},
      ui = {
        border = "rounded",
        icons = {
          package_installed = icons.ui.Circle,
          -- package_pending = "➜",
          package_uninstalled = icons.ui.UnfilledCircle,
        },
      },
      log_level = vim.log.levels.INFO,
      max_concurrent_installers = 4,
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require "mason-registry"
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger {
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          }
        end, 100)
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
    keys = {
      { "<leader>lI", "<cmd>Mason<cr>", desc = "Installer Info" },
    },
  },

  {
    "mason-org/mason-lspconfig.nvim",
    version = "^1.32.0",
  },
}
