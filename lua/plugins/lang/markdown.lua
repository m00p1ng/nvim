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
        filetypes = { "markdown" },
      },
      markdown = {
        headings = {
          shift_width = 1,
        },
      },
    },
    init = function()
      require("which-key").add {
        { "<leader>m", group = "Markdown" },
      }
    end,
    keys = {
      { "<leader>mt", "<cmd>Markview<cr>", desc = "Toggle preview", buffer = true, ft = { "markdown" } },
      { "<leader>ms", "<cmd>Markview splitToggle<cr>", desc = "Toggle split", buffer = true, ft = { "markdown" } },
    },
  },
}
