require("utils").add_ui_ft(
  "snacks_dashboard",
  "snacks_input",
  "snacks_notif",
  "snacks_notif_history",
  "snacks_picker_input",
  "snacks_picker_preview",
  "snacks_picker_list"
)

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
  { import = "plugins.snacks.debug" },
  { import = "plugins.snacks.image" },
  { import = "plugins.snacks.indent" },
  { import = "plugins.snacks.input" },
  { import = "plugins.snacks.notifier" },
  { import = "plugins.snacks.picker" },
  { import = "plugins.snacks.toggle" },
  { import = "plugins.snacks.words" },
}
