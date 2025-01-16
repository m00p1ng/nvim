return {
  "folke/snacks.nvim",
  opts = function()
    local snacks = require "snacks"

    snacks.toggle.line_number():map "<leader>oL"
    snacks.toggle.option("relativenumber", { name = "Relative Number" }):map "<leader>ol"
    snacks.toggle.option("wrap", { name = "Wrap" }):map "<leader>ow"
    snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map "<leader>ob"
    snacks.toggle.profiler():map "<leader>op"
  end,
}
