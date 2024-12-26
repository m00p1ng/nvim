return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    indent = {
      enabled = true,
      indent = {
        char = "▏",
      },
      scope = {
        char = "▏",
      },
      animate = {
        enabled = false,
      },
    },
  },
}
