return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      provider = "copilot",
    },
  },

  {
    "OXY2DEV/markview.nvim",
    optional = true,
    opts_extend = { "preview.filetypes" },
    opts = {
      preview = {
        filetypes = { "Avante" },
      },
    },
  },
}
