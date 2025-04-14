require("utils").add_ui_ft "codecompanion"

return {
  {
    "olimorris/codecompanion.nvim",
    event = "VeryLazy",
    opts = {
      display = {
        chat = {
          window = {
            width = 0.3,
            opts = {
              number = false,
            },
          },
        },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        command = "cab cc CodeCompanion",
        group = vim.api.nvim_create_augroup("CodeCompanion_ab", { clear = true }),
      })
    end,
    keys = {
      { "<leader>ao", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CodeCompanion: Chat" },
      { "<leader>aa", "<cmd>CodeCompanionChat Add<cr>", desc = "CodeCompanion: Add", mode = { "n", "v" } },
      { "<leader>ac", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion: Action", mode = { "n", "v" } },
      { "<leader>ae", "<cmd>CodeCompanion /explain<cr>", desc = "CodeCompanion: Explain", mode = { "n", "v" } },
      { "<leader>at", "<cmd>CodeCompanion /tests<cr>", desc = "CodeCompanion: Unit test", mode = { "n", "v" } },
      { "<leader>af", "<cmd>CodeCompanion /fix<cr>", desc = "CodeCompanion: Fix", mode = { "n", "v" } },
      { "<leader>al", "<cmd>CodeCompanion /lsp<cr>", desc = "CodeCompanion: LSP", mode = { "n", "v" } },
    },
  },

  {
    "OXY2DEV/markview.nvim",
    optional = true,
    opts_extend = {
      "preview.filetypes",
      "preview.modes",
      "preview.hybrid_modes",
    },
    opts = {
      preview = {
        filetypes = { "codecompanion" },
        ignore_buftypes = {},
        modes = { "i" },
        hybrid_modes = { "i" },
        callbacks = {
          on_mode_change = function(buf, wins, current_mode)
            local markview = require "markview"

            local ft = vim.bo[buf].ft
            if ft == "markdown" then
              markview.actions.disable(buf)
            elseif ft == "codecompanion" then
              markview.actions.hybridDisable(buf)
            end
          end,
        },
      },
    },
  },

  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      sources = {
        per_filetype = {
          codecompanion = { "codecompanion" },
        },
      },
    },
  },
}
