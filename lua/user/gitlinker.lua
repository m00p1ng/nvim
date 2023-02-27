return {
  "ruifm/gitlinker.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = function()
    return {
      opts = {
        add_current_line_on_normal_mode = true,
        action_callback = require("gitlinker.actions").open_in_browser,
        print_url = false,
        mappings = nil,
      },
    }
  end,
}
