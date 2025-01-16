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
