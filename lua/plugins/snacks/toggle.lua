return {
  "folke/snacks.nvim",
  opts = function()
    Snacks.toggle.line_number():map "<leader>oL"
    Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map "<leader>ol"
    Snacks.toggle.option("wrap", { name = "Wrap" }):map "<leader>ow"
    Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map "<leader>ob"
    Snacks.toggle.profiler():map "<leader>op"
    Snacks.toggle.inlay_hints():map "<leader>oi"
  end,
}
