return {
  "OXY2DEV/markview.nvim",
  ft = "markdown",
  opts = {
    restore_conceallevel = true,
    restore_concealcursor = false,

    buf_ignore = { "nofile" },

    modes = { "n" },

    headings = {
      enable = true,
      shift_width = 1,

      heading_1 = {
        style = "icon",
        sign = "󰌕 ",
        sign_hl = "markview_red_fg",

        icon = "󰼏  ",
        hl = "markview_red",
      },
      heading_2 = {
        style = "icon",
        sign = "󰌖 ",
        sign_hl = "markview_orange_fg",

        icon = "󰎨  ",
        hl = "markview_orange",
      },
      heading_3 = {
        style = "icon",

        icon = "󰼑  ",
        hl = "markview_yellow",
      },
      heading_4 = {
        style = "icon",

        icon = "󰎲  ",
        hl = "markview_green",
      },
      heading_5 = {
        style = "icon",

        icon = "󰼓  ",
        hl = "markview_blue",
      },
      heading_6 = {
        style = "icon",

        icon = "󰎴  ",
        hl = "markview_mauve",
      },
    },

    code_blocks = {
      enable = true,

      style = "language",
      hl = "dark",

      position = "overlay",

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
        border_hl = { "gradient_0", "gradient_1", "gradient_2", "gradient_3", "gradient_4", "gradient_5", "gradient_6" },
      },

      callouts = {
        --- From `Obsidian`
        {
          match_string = "ABSTRACT",
          callout_preview = "󱉫 Abstract",
          callout_preview_hl = "markview_blue_fg",

          custom_title = true,
          custom_icon = "󱉫 ",

          border = "▋",
          border_hl = "markview_blue_fg",
        },
        {
          match_string = "TODO",
          callout_preview = " Todo",
          callout_preview_hl = "markview_blue_fg",

          custom_title = true,
          custom_icon = " ",

          border = "▋",
          border_hl = "markview_blue_fg",
        },
        {
          match_string = "SUCCESS",
          callout_preview = "󰗠 Success",
          callout_preview_hl = "markview_green_fg",

          custom_title = true,
          custom_icon = "󰗠 ",

          border = "▋",
          border_hl = "markview_green_fg",
        },
        {
          match_string = "QUESTION",
          callout_preview = "󰋗 Question",
          callout_preview_hl = "markview_orange_fg",

          custom_title = true,
          custom_icon = "󰋗 ",

          border = "▋",
          border_hl = "markview_orange_fg",
        },
        {
          match_string = "FAILURE",
          callout_preview = "󰅙 Failure",
          callout_preview_hl = "markview_red_fg",

          custom_title = true,
          custom_icon = "󰅙 ",

          border = "▋",
          border_hl = "markview_red_fg",
        },
        {
          match_string = "DANGER",
          callout_preview = " Danger",
          callout_preview_hl = "markview_red_fg",

          custom_title = true,
          custom_icon = "  ",

          border = "▋",
          border_hl = "markview_red_fg",
        },
        {
          match_string = "BUG",
          callout_preview = " Bug",
          callout_preview_hl = "markview_red_fg",

          custom_title = true,
          custom_icon = "  ",

          border = "▋",
          border_hl = "markview_red_fg",
        },
        {
          match_string = "EXAMPLE",
          callout_preview = "󱖫 Example",
          callout_preview_hl = "markview_mauve_fg",

          custom_title = true,
          custom_icon = " 󱖫 ",

          border = "▋",
          border_hl = "markview_mauve_fg",
        },
        {
          match_string = "QUOTE",
          callout_preview = " Quote",
          callout_preview_hl = "markview_grey_fg",

          custom_title = true,
          custom_icon = "  ",

          border = "▋",
          border_hl = "markview_grey_fg",
        },

        {
          match_string = "NOTE",
          callout_preview = "󰋽 Note",
          callout_preview_hl = "markview_blue_fg",

          border = "▋",
          border_hl = "markview_blue_fg",
        },
        {
          match_string = "TIP",
          callout_preview = " Tip",
          callout_preview_hl = "markview_green_fg",

          border = "▋",
          border_hl = "markview_green_fg",
        },
        {
          match_string = "IMPORTANT",
          callout_preview = " Important",
          callout_preview_hl = "markview_yellow_fg",

          border = "▋",
          border_hl = "markview_yellow_fg",
        },
        {
          match_string = "WARNING",
          callout_preview = " Warning",
          callout_preview_hl = "markview_orange_fg",

          border = "▋",
          border_hl = "markview_orange_fg",
        },
        {
          match_string = "CAUTION",
          callout_preview = "󰳦 Caution",
          callout_preview_hl = "rainbow1",

          border = "▋",
          border_hl = "rainbow1",
        },
        {
          match_string = "CUSTOM",
          callout_preview = " 󰠳 Custom",
          callout_preview_hl = "rainbow3",

          custom_title = true,
          custom_icon = " 󰠳 ",

          border = "▋",
          border_hl = "rainbow3",
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
            return math.floor((vim.o.columns - 3) / 2)
          end,

          text = "─",
          hl = {
            "gradient_6",
            "gradient_5",
            "gradient_4",
            "gradient_3",
            "gradient_2",
            "gradient_1",
            "gradient_0",
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
            return math.ceil((vim.o.columns - 3) / 2)
          end,

          direction = "right",
          text = "─",
          hl = {
            "gradient_6",
            "gradient_5",
            "gradient_4",
            "gradient_3",
            "gradient_2",
            "gradient_1",
            "gradient_0",
          },
        },
      },
    },

    hyperlinks = {
      enable = true,

      icon = "󰌷 ",
      icon_hl = "markdownLinkText",
      text_hl = "markdownLinkText",
    },
    images = {
      enable = true,

      icon = "󰥶 ",
      icon_hl = "markdownLinkText",
      text_hl = "markdownLinkText",
    },

    inline_codes = {
      enable = true,
      corner_left = " ",
      corner_right = " ",

      hl = "dark_2",
    },

    list_items = {
      marker_plus = {
        add_padding = true,

        text = "•",
        hl = "rainbow2",
      },
      marker_minus = {
        add_padding = true,

        text = "•",
        hl = "rainbow4",
      },
      marker_star = {
        add_padding = true,

        text = "•",
        text_hl = "rainbow2",
      },
      marker_dot = {
        add_padding = true,
      },
    },

    checkboxes = {
      enable = true,

      checked = {
        text = "✔",
        hl = "@markup.list.checked",
      },
      pending = {
        text = "◯",
        hl = "@markup.raw",
      },
      unchecked = {
        text = "✘",
        hl = "@markup.list.unchecked",
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
        "red_fg", "red_fg", "red_fg", "red_fg",
        "red_fg", "red_fg", "red_fg", "red_fg",
        "red_fg", "red_fg", "red_fg", "red_fg",

        "red_fg", "red_fg", "red_fg", "red_fg",
      },

      use_virt_lines = false,
    },
  },
}
