return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      dashboard = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      words = { enabled = true },
      profiler = { enabled = true },
    },
  },

  { import = "plugins.snacks.dashboard" },
  { import = "plugins.snacks.indent" },
  { import = "plugins.snacks.input" },
  { import = "plugins.snacks.notifier" },
  { import = "plugins.snacks.picker" },
  { import = "plugins.snacks.toggle" },
  { import = "plugins.snacks.words" },
}
