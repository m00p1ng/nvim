return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    input = {
      icon = "",
      icon_hl = "SnacksInputIcon",
      icon_pos = "left",
      prompt_pos = "title",
      win = { style = "input" },
      expand = true,
    },
    styles = {
      input = {
        backdrop = false,
        position = "float",
        border = "rounded",
        title_pos = "left",
        height = 1,
        width = 30,
        max_width = 40,
        noautocmd = true,
        relative = "cursor",
        row = 1,
        col = 0,
        wo = {
          cursorline = false,
        },
        bo = {
          filetype = "snacks_input",
          buftype = "prompt",
        },
        b = {
          completion = false, -- disable blink completions in input
        },
        keys = {
          i_esc = { "<esc>", { "cancel" }, mode = "i", expr = true },
          i_cr = { "<cr>", { "cmp_accept", "confirm" }, mode = "i", expr = true },
          i_tab = { "<tab>", { "cmp_select_next", "cmp" }, mode = "i", expr = true },
          i_ctrl_w = { "<c-w>", "<c-s-w>", mode = "i", expr = true },
          i_ctrl_a = { "<c-a>", "<Home>", mode = "i", expr = true },
          i_ctrl_e = { "<c-e>", "<End>", mode = "i", expr = true },
          i_up = { "<up>", { "hist_up" }, mode = { "i", "n" } },
          i_down = { "<down>", { "hist_down" }, mode = { "i", "n" } },
          q = "cancel",
        },
      },
    },
  },
}
