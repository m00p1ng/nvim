require("utils").add_ui_ft "codecompanion"

return {
  {
    "olimorris/codecompanion.nvim",
    opts = {
      display = {
        chat = {
          window = {
            width = 0.3,
            opts = {
              number = false,
            },
          },
          start_in_insert_mode = true,
        },
      },
    },
  },

  {
    "OXY2DEV/markview.nvim",
    optional = true,
    ft = { "codecompanion" },
    opts_extend = { "preview.filetypes" },
    opts = {
      preview = {
        filetypes = { "codecompanion" },
        ignore_buftypes = {},
      },
    },
  },

  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      sources = {
        per_filetype = {
          codecompanion = { "codecompanion" },
        },
      },
    },
  },
}
