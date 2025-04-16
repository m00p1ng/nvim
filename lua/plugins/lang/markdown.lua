return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {},
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = { "markdown", "markdown_inline" } },
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    init = function()
      require("which-key").add {
        { "<leader>m", group = "Markdown" },
      }
    end,
    opts_extend = { "preview.filetypes" },
    opts = {
      preview = {
        enable = true,
        filetypes = { "markdown" },
        modes = { "n", "no", "c" },
        hybrid_modes = { "n" },
        callbacks = {
          on_mode_change = function(buf, wins, current_mode)
            local markview = require "markview"

            local ft = vim.bo[buf].ft
            if ft == "markdown" then
              markview.actions.disable(buf)
            end
          end,
        },
      },
      markdown = {
        headings = {
          shift_width = 1,
        },
      },
      latex = false,
    },
    keys = {
      { "<leader>mt", "<cmd>Markview<cr>", desc = "Toggle preview", buffer = true, ft = { "markdown" } },
      { "<leader>ms", "<cmd>Markview splitToggle<cr>", desc = "Toggle split", buffer = true, ft = { "markdown" } },
    },
  },
}
