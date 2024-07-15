return {
  "OXY2DEV/markview.nvim",
  ft = "markdown",
  opts = {
    restore_conceallevel = true,
    restore_concealcursor = false,

    options = {
      on_enable = {
        conceallevel = 2,
        concealcursor = "n",
      },

      on_disable = {
        conceallevel = 0,
        concealcursor = "",
      },
    },

    buf_ignore = { "nofile" },

    modes = { "n", "no" },

    headings = {
      enable = true,
      shift_width = 1,

      heading_1 = {
        style = "icon",
        sign = "󰌕 ",
        sign_hl = "MarkviewCol1Fg",

        icon = "󰼏  ",
        hl = "MarkviewCol1",
      },
      heading_2 = {
        style = "icon",
        sign = "󰌖 ",
        sign_hl = "MarkviewCol2Fg",

        icon = "󰎨  ",
        hl = "MarkviewCol2",
      },
      heading_3 = {
        style = "icon",

        icon = "󰼑  ",
        hl = "MarkviewCol3",
      },
      heading_4 = {
        style = "icon",

        icon = "󰎲  ",
        hl = "MarkviewCol4",
      },
      heading_5 = {
        style = "icon",

        icon = "󰼓  ",
        hl = "MarkviewCol5",
      },
      heading_6 = {
        style = "icon",

        icon = "󰎴  ",
        hl = "MarkviewCol6",
      },

      setext_1 = {
        style = "github",

        icon = "   ",
        hl = "MarkviewCol1",
        underline = "━",
      },
      setext_2 = {
        style = "github",

        icon = "   ",
        hl = "MarkviewCol2",
        underline = "─",
      },
    },

    code_blocks = {
      enable = true,

      style = "language",
      hl = "Layer2",

      min_width = 60,
      pad_amount = 3,

      language_names = {
        { "py", "python" },
        { "cpp", "C++" },
      },
      language_direction = "right",

      sign = true,
      sign_hl = nil,
    },

    block_quotes = {
      enable = true,

      default = {
        border = "▋",
        border_hl = "MarkviewCol7Fg",
      },

      callouts = {
        --- From `Obsidian`
        {
          match_string = "ABSTRACT",
          callout_preview = "󱉫 Abstract",
          callout_preview_hl = "MarkviewCol5Fg",

          custom_title = true,
          custom_icon = "󱉫 ",

          border = "▋",
          border_hl = "MarkviewCol5Fg",
        },
        {
          match_string = "TODO",
          callout_preview = " Todo",
          callout_preview_hl = "MarkviewCol5Fg",

          custom_title = true,
          custom_icon = " ",

          border = "▋",
          border_hl = "MarkviewCol5Fg",
        },
        {
          match_string = "SUCCESS",
          callout_preview = "󰗠 Success",
          callout_preview_hl = "MarkviewCol4Fg",

          custom_title = true,
          custom_icon = "󰗠 ",

          border = "▋",
          border_hl = "MarkviewCol4Fg",
        },
        {
          match_string = "QUESTION",
          callout_preview = "󰋗 Question",
          callout_preview_hl = "MarkviewCol2Fg",

          custom_title = true,
          custom_icon = "󰋗 ",

          border = "▋",
          border_hl = "MarkviewCol2Fg",
        },
        {
          match_string = "FAILURE",
          callout_preview = "󰅙 Failure",
          callout_preview_hl = "MarkviewCol1Fg",

          custom_title = true,
          custom_icon = "󰅙 ",

          border = "▋",
          border_hl = "MarkviewCol1Fg",
        },
        {
          match_string = "DANGER",
          callout_preview = " Danger",
          callout_preview_hl = "MarkviewCol1Fg",

          custom_title = true,
          custom_icon = "  ",

          border = "▋",
          border_hl = "MarkviewCol1Fg",
        },
        {
          match_string = "BUG",
          callout_preview = " Bug",
          callout_preview_hl = "MarkviewCol1Fg",

          custom_title = true,
          custom_icon = "  ",

          border = "▋",
          border_hl = "MarkviewCol1Fg",
        },
        {
          match_string = "EXAMPLE",
          callout_preview = "󱖫 Example",
          callout_preview_hl = "MarkviewCol6Fg",

          custom_title = true,
          custom_icon = " 󱖫 ",

          border = "▋",
          border_hl = "MarkviewCol6Fg",
        },
        {
          match_string = "QUOTE",
          callout_preview = " Quote",
          callout_preview_hl = "MarkviewCol7Fg",

          custom_title = true,
          custom_icon = "  ",

          border = "▋",
          border_hl = "MarkviewCol7Fg",
        },

        {
          match_string = "NOTE",
          callout_preview = "󰋽 Note",
          callout_preview_hl = "MarkviewCol5Fg",

          border = "▋",
          border_hl = "MarkviewCol5Fg",
        },
        {
          match_string = "TIP",
          callout_preview = " Tip",
          callout_preview_hl = "MarkviewCol4Fg",

          border = "▋",
          border_hl = "MarkviewCol4Fg",
        },
        {
          match_string = "IMPORTANT",
          callout_preview = " Important",
          callout_preview_hl = "MarkviewCol3Fg",

          border = "▋",
          border_hl = "MarkviewCol3Fg",
        },
        {
          match_string = "WARNING",
          callout_preview = " Warning",
          callout_preview_hl = "MarkviewCol2Fg",

          border = "▋",
          border_hl = "MarkviewCol2Fg",
        },
        {
          match_string = "CAUTION",
          callout_preview = "󰳦 Caution",
          callout_preview_hl = "MarkviewCol1Fg",

          border = "▋",
          border_hl = "MarkviewCol1Fg",
        },
        {
          match_string = "CUSTOM",
          callout_preview = "󰠳 Custom",
          callout_preview_hl = "MarkviewCol3Fg",

          custom_title = true,
          custom_icon = " 󰠳 ",

          border = "▋",
          border_hl = "MarkviewCol3Fg",
        },
      },
    },
    horizontal_rules = {
      enable = true,

      position = "overlay",
      parts = {
        {
          type = "repeating",
          repeat_amount = function() --[[@as function]]
            local textoff = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1].textoff

            return math.floor((vim.o.columns - textoff - 3) / 2)
          end,

          text = "─",
          hl = {
            "MarkviewGradient1",
            "MarkviewGradient2",
            "MarkviewGradient3",
            "MarkviewGradient4",
            "MarkviewGradient5",
            "MarkviewGradient6",
            "MarkviewGradient7",
            "MarkviewGradient8",
            "MarkviewGradient9",
            "MarkviewGradient10",
          },
        },
        {
          type = "text",
          text = "  ",

          repeat_amount = vim.o.columns,
        },
        {
          type = "repeating",
          repeat_amount = function() --[[@as function]]
            local textoff = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1].textoff

            return math.ceil((vim.o.columns - textoff - 3) / 2)
          end,

          direction = "right",
          text = "─",
          hl = {
            "MarkviewGradient1",
            "MarkviewGradient2",
            "MarkviewGradient3",
            "MarkviewGradient4",
            "MarkviewGradient5",
            "MarkviewGradient6",
            "MarkviewGradient7",
            "MarkviewGradient8",
            "MarkviewGradient9",
            "MarkviewGradient10",
          },
        },
      },
    },

    links = {
      enable = true,

      inline_links = {
        icon = "󰌷 ",
        icon_hl = "markdownLinkText",
        hl = "markdownLinkText",
      },
      images = {
        icon = "󰥶 ",
        icon_hl = "markdownLinkText",
        hl = "markdownLinkText",
      },
      emails = {
        icon = " ",
        icon_hl = "@markup.link.url",
        hl = "@markup.link.url",
      },
    },

    inline_codes = {
      enable = true,
      corner_left = " ",
      corner_right = " ",

      hl = "Layer",
    },

    list_items = {
      marker_minus = {
        add_padding = true,

        text = "",
        hl = "markviewCol2Fg",
      },
      marker_plus = {
        add_padding = true,

        text = "",
        hl = "markviewCol4Fg",
      },
      marker_star = {
        add_padding = true,

        text = "",
        text_hl = "markviewCol6Fg",
      },
      marker_dot = {
        add_padding = true,
      },
    },

    checkboxes = {
      enable = true,

      checked = {
        text = "✔",
        hl = "markviewCol4Fg",
      },
      pending = {
        text = "◯",
        hl = "MarkviewCol2Fg",
      },
      unchecked = {
        text = "✘",
        hl = "MarkviewCol1Fg",
      },
    },

    tables = {
      enable = true,
      text = {
        "╭", "─", "╮", "┬",
        "├", "│", "┤", "┼",
        "╰", "─", "╯", "┴",

        "╼", "╾", "╴", "╶",
      },
      hl = {
        "MarkviewCol1Fg", "MarkviewCol1Fg", "MarkviewCol1Fg", "MarkviewCol1Fg",
        "MarkviewCol1Fg", "MarkviewCol1Fg", "MarkviewCol1Fg", "MarkviewCol1Fg",
        "MarkviewCol1Fg", "MarkviewCol1Fg", "MarkviewCol1Fg", "MarkviewCol1Fg",

        "MarkviewCol1Fg", "MarkviewCol1Fg", "MarkviewCol1Fg", "MarkviewCol1Fg",
      },

      use_virt_lines = false,
    },
  },
}
