local icons = require "utils.icons"

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    init = function()
      -- setup keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buffer = args.buf ---@type number
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require("plugins.lsp.keymaps").on_attach(client, buffer)
        end,
      })

      -- diagnostics
      vim.diagnostic.config {
        underline = true,
        update_in_insert = true,
        -- virtual_text = {
        --   current_line = true,
        -- },
        virtual_text = true,
        severity_sort = true,
        float = {
          border = "rounded",
          -- wrap_at = 80,
          source = true,
          header = "",
          -- prefix = "",
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
            [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
          },
        },
      }
    end,
    keys = {
      { "<leader>lR", "<cmd>LspRestart<cr>", desc = "Restart" },
    },
  },

  { import = "plugins.lsp.conform" },
  { import = "plugins.lsp.mason" },
  { import = "plugins.lsp.lsp_signature" },
  { import = "plugins.lsp.nvim-lint" },
  { import = "plugins.lsp.neoconf" },
}
