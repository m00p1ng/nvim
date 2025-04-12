require("utils").add_ui_ft("Avante", "AvanteInput", "AvanteSelectedFiles")
require("utils.winbar").add_plugin_winbar("Avante", "AvanteInput", "AvanteSelectedFiles")

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
        ignore_buftypes = {},
      },
      max_length = 99999,
    },
  },
}
