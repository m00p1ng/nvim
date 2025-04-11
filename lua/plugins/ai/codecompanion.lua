require("utils").add_ui_ft "codecompanion"

return {
  {
    "olimorris/codecompanion.nvim",
    opts = {},
  },

  {
    "OXY2DEV/markview.nvim",
    opts_extend = { "preview.filetypes" },
    opts = {
      preview = {
        filetypes = { "codecompanion" },
      },
    },
  },

  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        per_filetype = {
          codecompanion = { "codecompanion" },
        },
      },
    },
  },
}
