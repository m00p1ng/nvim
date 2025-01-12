return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      dashboard = { enabled = true },
      indent = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      words = { enabled = true },
      profiler = { enabled = true },
    },
    config = function(_, opts)
      local snacks = require "snacks"
      snacks.setup(opts)

      snacks.toggle.line_number():map "<leader>oL"
      snacks.toggle.option("relativenumber", { name = "Relative Number" }):map "<leader>ol"
      snacks.toggle.option("wrap", { name = "Wrap" }):map "<leader>ow"
      snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map "<leader>ob"
      snacks.toggle.profiler():map "<leader>op"
    end,
  },

  { import = "plugins.snacks.dashboard" },
  { import = "plugins.snacks.indent" },
  { import = "plugins.snacks.notifier" },
  { import = "plugins.snacks.words" },
}
