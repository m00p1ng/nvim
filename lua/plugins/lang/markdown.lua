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
    ft = "markdown",
    opts = {
      initial_state = false,
      headings = {
        shift_width = 1,
      },
    },
  },
}
