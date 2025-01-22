return {
  "m4xshen/hardtime.nvim",
  enabled = false,
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  event = "VeryLazy",
  opts = {},
  keys = {
    { "<localleader>q", "<cmd>Hardtime disable<CR>", desc = "Disable Hardtime" },
  },
}
