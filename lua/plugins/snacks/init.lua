return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      dashboard = { enabled = true },
      indent = { enabled = true },
      quickfile = { enabled = true },
    },
  },

  { import = "plugins.snacks.dashboard" },
  { import = "plugins.snacks.indent" },
}
