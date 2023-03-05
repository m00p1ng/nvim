return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local f = require "utils"
    local dark = "#181818"

    vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#e8ab53", bg = dark })
    vim.api.nvim_set_hl(0, "SLBranchName", { fg = "#abb2bf", bg = dark, bold = false })
    vim.api.nvim_set_hl(0, "SLLocation", { fg = "#5e81ac", bg = dark })
    vim.api.nvim_set_hl(0, "SLFiletype", { fg = "#88c0d0", bg = dark })
    vim.api.nvim_set_hl(0, "SLIndent", { fg = "#a3be8c", bg = dark })
    vim.api.nvim_set_hl(0, "SLSeparator", { fg = "#6b727f", bg = dark, italic = true })
    vim.api.nvim_set_hl(0, "SLError", { fg = "#bf616a", bg = dark })
    vim.api.nvim_set_hl(0, "SLWarning", { fg = "#d7ba7d", bg = dark })
    vim.api.nvim_set_hl(0, "SLFileSize", { fg = "#abb2bf", bg = dark })
    vim.api.nvim_set_hl(0, "SLTabs", { fg = "#6CC644", bg = dark })

    local hl_str = function(str, hl)
      return "%#" .. hl .. "#" .. str
    end

    local mode_color = {
      n = "#5e81ac",
      i = "#c68a75",
      v = "#b668cd",
      [""] = "#b668cd",
      V = "#b668cd",
      -- c      = '#b5cea8',
      -- c      = '#d7ba7d',
      c = "#46a6b2",
      no = "#d16d9e",
      s = "#a3be8c",
      S = "#c68a75",
      [""] = "#c68a75",
      ic = "#bf616a",
      R = "#d16d9e",
      Rv = "#bf616a",
      cv = "#5e81ac",
      ce = "#5e81ac",
      r = "#bf616a",
      rm = "#46a6b2",
      ["r?"] = "#46a6b2",
      ["!"] = "#46a6b2",
      t = "#bf616a",
    }

    local icons = require "utils.icons"

    local diagnostics = {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      sections = { "error", "warn" },
      symbols = {
        error = "%#SLError#" .. icons.diagnostics.Error .. " ",
        warn = "%#SLWarning#" .. icons.diagnostics.Warning .. " ",
      },
      colored = false,
      update_in_insert = false,
      always_visible = true,
    }

    local mode = {
      function()
        return "▌"
      end,
      color = function()
        return { fg = mode_color[vim.fn.mode()], bg = "NONE" }
      end,
      padding = 0,
    }

    local filetype = {
      "filetype",
      fmt = function(str)
        local return_val = function(str)
          return hl_str(str, "SLFiletype")
        end

        if str == "TelescopePrompt" then
          return return_val(icons.ui.Telescope)
        end

        if f.is_ui_filetype(str) or str == "" then
          return ""
        else
          return return_val(str)
        end
      end,
      icons_enabled = false,
      on_click = function()
        vim.cmd ":Telescope filetypes"
      end,
    }

    local branch = {
      "branch",
      icons_enabled = true,
      icon = "%#SLGitIcon#" .. icons.git.Branch .. "%*" .. "%#SLBranchName#",
      colored = false,
      fmt = function(str)
        if str == "" or str == nil then
          return "[unknown]"
        end

        local max_length = 30
        if str:len() > max_length then
          return str:sub(1, max_length) .. "..."
        end

        return str
      end,
      on_click = function()
        vim.cmd ":Telescope git_branches"
      end,
    }

    local spaces = {
      function()
        local buf_ft = vim.bo.filetype

        if f.is_ui_filetype(buf_ft) then
          return ""
        end

        local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")

        if shiftwidth == nil then
          return ""
        end

        -- TODO: update codicons and use their indent
        return hl_str(icons.ui.ShiftWidth .. " " .. shiftwidth, "SLIndent")
      end,
    }

    local location = {
      "location",
      fmt = function(str)
        return hl_str(str, "SLLocation")
      end,
    }

    local filesize = {
      function()
        local buf_ft = vim.bo.filetype

        if f.is_ui_filetype(buf_ft) then
          return ""
        end

        local size = vim.fn.wordcount().bytes

        local suffixes = { "B", "KB", "MB", "GB" }

        local i = 1
        while size > 1024 and i < #suffixes do
          size = size / 1024
          i = i + 1
        end

        local format = i == 1 and "%d%s" or "%.1f%s"
        return hl_str(string.format(format, size, suffixes[i]), "SLFilesize")
      end,
    }

    local tabs = {
      function()
        local num_tabs = #vim.api.nvim_list_tabpages()

        if num_tabs > 1 then
          local tabpage_number = tostring(vim.api.nvim_tabpage_get_number(0))
          return hl_str(" " .. tabpage_number .. "/" .. tostring(num_tabs), "SLTabs")
        end

        return ""
      end,
    }

    -- recording @q
    local status_mode = {
      require("noice").api.status.mode.get,
      cond = require("noice").api.status.mode.has,
    }

    local search_result = {
      require("noice").api.status.search.get,
      cond = require("noice").api.status.search.has,
    }

    local updated_plugin = {
      require("lazy.status").updates,
      cond = require("lazy.status").has_updates,
      color = { fg = "Special" },
    }

    return {
      options = {
        globalstatus = true,
        icons_enabled = true,
        theme = "darkplus_dark",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = { "alpha", "dashboard" },
        },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { mode, branch },
        lualine_b = { diagnostics, tabs },
        lualine_c = { status_mode, search_result },
        lualine_x = { filesize },
        lualine_y = { spaces, filetype },
        lualine_z = { updated_plugin, location },
      },
      tabline = {},
      winbar = {},
      extensions = {},
    }
  end,
}
