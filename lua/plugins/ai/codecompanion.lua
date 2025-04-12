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
        command = "ab Chat CodeCompanion",
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
    opts_extend = { "preview.filetypes" },
    opts = {
      preview = {
        filetypes = { "codecompanion" },
        ignore_buftypes = {},
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
