return {
  {
    "nvim-lspconfig",
    opts = {
      servers = {
        bashls = {},
      },
    },
  },
  {
    "nvim-treesitter",
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = { "bash" } },
  },
  {
    "mason.nvim",
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = { "shfmt", "shellcheck" } },
  },
  {
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        sh = { "shfmt" },
      },
    },
  },
}
