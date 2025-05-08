return {
  {
    "nvim-lspconfig",
    opts = {
      servers = {
        cssls = {},
      },
    },
  },
  {
    "nvim-treesitter",
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = { "css", "scss" } },
  },
}
