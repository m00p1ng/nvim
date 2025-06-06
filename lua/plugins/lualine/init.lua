return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local c = require "plugins.lualine.componenets"

    return {
      options = {
        icons_enabled = true,
        theme = "mooping",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = { "snacks_dashboard" },
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 100,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { c.branch },
        lualine_b = { c.diagnostics, c.tabs },
        lualine_c = { c.status_mode, c.search_result, c.current_signature },
        lualine_x = { "codecompanion", c.autoformat, c.command, c.filesize },
        lualine_y = { c.spaces, c.filetype, c.updated_plugin },
        lualine_z = { c.location, c.progress },
      },
      tabline = {},
      winbar = {},
      extensions = {},
    }
  end,
}
