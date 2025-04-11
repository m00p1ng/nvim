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
    opts_extend = { "preview.filetypes" },
    opts = {
      preview = {
        enable = true,
        -- hybrid_modes = { "n" },
        filetypes = { "markdown" },
      },
      markdown = {
        headings = {
          shift_width = 1,
        },
      },
    },
  },
  -- {
  --   "OXY2DEV/markview.nvim",
  --   opts = function()
  --     require("which-key").add {
  --       { "<leader>m", group = "Markdown" },
  --       { "<leader>mt", "<cmd>Markview<cr>", desc = "Toggle preview", buffer = true },
  --       { "<leader>ms", "<cmd>Markview splitToggle<cr>", desc = "Toggle split", buffer = true },
  --     }
  --   end,
  -- },
}
