return {
  "folke/snacks.nvim",
  opts = function()
    Snacks.toggle.line_number():map "<leader>oL"
    Snacks.toggle.option("relativenumber", { name = "Relative Number", global = true }):map "<leader>ol"
    Snacks.toggle.option("wrap", { name = "Wrap" }):map "<leader>ow"
    Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map "<leader>ob"
    Snacks.toggle.profiler():map "<leader>op"
    Snacks.toggle.inlay_hints():map "<leader>oi"

    Snacks.toggle({
      name = "List Chars",
      get = function()
        return vim.opt.list:get()
      end,
      set = function(state)
        vim.opt.list = state
        if state then
          Snacks.indent.disable()
        else
          Snacks.indent.enable()
        end
      end,
    }):map "<leader>oc"
  end,
}
