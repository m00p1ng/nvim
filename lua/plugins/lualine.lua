return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  cond = vim.g.vscode == nil,
  opts = function()
    local f = require "utils"
    local dark = "#181825"

    vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#fab387", bg = dark })
    vim.api.nvim_set_hl(0, "SLBranchName", { fg = "#bac2de", bg = dark, bold = false })
    vim.api.nvim_set_hl(0, "SLLocation", { fg = "#89b4fa", bg = dark })
    vim.api.nvim_set_hl(0, "SLFiletype", { fg = "#89dceb", bg = dark })
    vim.api.nvim_set_hl(0, "SLIndent", { fg = "#a6e3a1", bg = dark })
    vim.api.nvim_set_hl(0, "SLSeparator", { fg = "#6c7086", bg = dark, italic = true })
    vim.api.nvim_set_hl(0, "SLError", { fg = "#f38ba8", bg = dark })
    vim.api.nvim_set_hl(0, "SLWarning", { fg = "#f9e2af", bg = dark })
    vim.api.nvim_set_hl(0, "SLFileSize", { fg = "#bac2de", bg = dark })
    vim.api.nvim_set_hl(0, "SLTabs", { fg = "#a6e3a1", bg = dark })

    local hl_str = function(str, hl)
      return "%#" .. hl .. "#" .. str
    end

    local mode_color = {
      n = "#89b4fa",
      i = "#fab387",
      v = "#cba6f7",
      [""] = "#cba6f7",
      V = "#cba6f7",
      -- c      = '#b5cea8',
      -- c      = '#f9e2af',
      c = "#74c7ec",
      no = "#eba0ac",
      s = "#a6e3a1",
      S = "#fab387",
      [""] = "#fab387",
      ic = "#f38ba8",
      R = "#eba0ac",
      Rv = "#f38ba8",
      cv = "#89b4fa",
      ce = "#89b4fa",
      r = "#f38ba8",
      rm = "#74c7ec",
      ["r?"] = "#74c7ec",
      ["!"] = "#74c7ec",
      t = "#f38ba8",
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
          return str:sub(1, max_length) .. "…"
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

        local shiftwidth = f.get_buf_option "shiftwidth"
        if shiftwidth == nil then
          return ""
        end

        return hl_str(icons.ui.Tab .. shiftwidth, "SLIndent")
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

    local command = {
      require("noice").api.status.command.get,
      cond = require("noice").api.status.command.has,
      color = { fg = "#eba0ac" },
    }

    local updated_plugin = {
      require("lazy.status").updates,
      cond = require("lazy.status").has_updates,
      color = { fg = "Special", bg = "NONE" },
    }

    local current_signature = {
      function()
        local buf_ft = vim.bo.filetype

        if buf_ft == "TelescopePrompt" then
          return ""
        end

        local sig = require("lsp_signature").status_line(30)
        local hint = sig.hint

        if not require("utils").is_empty(hint) then
          return "%#SLSeparator# " .. hint .. "%*"
        end

        return ""
      end,
      padding = 0,
    }

    return {
      options = {
        icons_enabled = true,
        theme = "catppuccin-mocha",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = { "alpha", "dashboard" },
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { mode, branch },
        lualine_b = { diagnostics, tabs },
        lualine_c = { status_mode, search_result, current_signature },
        lualine_x = { command, filesize },
        lualine_y = { spaces, filetype },
        lualine_z = { updated_plugin, location },
      },
      tabline = {},
      winbar = {},
      extensions = {},
    }
  end,
}
