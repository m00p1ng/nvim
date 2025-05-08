return {
  {
    "nvim-lspconfig",
    opts = {
      servers = {
        sqlls = {},
      },
    },
  },
  {
    "nvim-treesitter",
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = { "sql" } },
  },

  -- {
  --   "mason.nvim",
  --   opts_extend = { "ensure_installed" },
  --   opts = { ensure_installed = { "sqlfluff" } },
  -- },
  -- {
  --   "mfussenegger/nvim-lint",
  --   opts = {
  --     linters_by_ft = {
  --       sql = { "sqlfluff" },
  --     },
  --   },
  -- },
  -- {
  --   "conform.nvim",
  --   opts = {
  --     formatters = {
  --       sqlfluff = { args = { "format", "--dialect=ansi", "-" } },
  --     },
  --     formatters_by_ft = {
  --       sql = { "sqlfluff" },
  --     },
  --   },
  -- },
}
