return {
  {
    "mason-lspconfig.nvim",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = { "marksman" },
    },
  },
  {
    "nvim-treesitter",
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = { "markdown", "markdown_inline" } },
  },

  -- Other extensions
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
      experimental = {
        check_rtp = false,
      },
    },
    keys = {
      { "<leader>mt", "<cmd>Markview<cr>", desc = "Toggle preview", buffer = true, ft = { "markdown" } },
      { "<leader>ms", "<cmd>Markview splitToggle<cr>", desc = "Toggle split", buffer = true, ft = { "markdown" } },
    },
  },
}
