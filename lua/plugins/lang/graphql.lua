return {
  {
    "nvim-lspconfig",
    opts = {
      servers = {
        graphql = {},
      },
    },
  },
  {
    "nvim-treesitter",
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = { "graphql" } },
  },
}
