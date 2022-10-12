local M = {}

M.get_filename = function()
  local filename = vim.fn.expand "%:t"
  local extension = vim.fn.expand "%:e"
  local f = require "user.function"

  if not f.is_empty(filename) then
    local file_icon, file_icon_color = require("nvim-web-devicons").get_icon_color(
      filename,
      extension,
      { default = true }
    )

    local hl_group = "FileIconColor" .. extension

    vim.api.nvim_set_hl(0, hl_group, { fg = file_icon_color })
    if f.is_empty(file_icon) then
      file_icon = ""
      file_icon_color = ""
    end
    vim.api.nvim_set_hl(0, "Winbar", { fg = "#6b737f" })


    local hl_filename
    if f.get_buf_option "mod" then
      hl_filename = "%#NvimTreeFileDirty#"
    else
      hl_filename = "%#Winbar#"
    end

    return " " .. "%#" .. hl_group .. "#" .. file_icon .. "%*" .. " " .. hl_filename .. vim.fn.expand('%:~:.') .. "%*"
  end
end

local get_gps = function()
  local status_gps_ok, gps = pcall(require, "nvim-navic")
  if not status_gps_ok then
    return ""
  end

  local status_ok, gps_location = pcall(gps.get_location, {})
  if not status_ok then
    return ""
  end

  if not gps.is_available() or gps_location == "error" then
    return ""
  end

  if not require("user.function").is_empty(gps_location) then
    return require("user.icons").ui.ChevronRight .. " " .. gps_location
  else
    return ""
  end
end

local excludes = function()
  local filetype = vim.bo.filetype
  local winbar_filetype_exclude = require('user.function').ui_filetypes

  if filetype == "dapui_hover" then
    return true
  end

  if filetype:find("^dap") ~= nil then
    return false
  end

  if vim.tbl_contains(winbar_filetype_exclude, filetype) then
    vim.opt_local.winbar = nil
    return true
  end
  return false
end

M.get_winbar = function()
  if excludes() then
    return
  end
  local f = require "user.function"
  local value = M.get_filename()

  if not f.is_empty(value) and f.get_buf_option "mod" then
    local mod = "%#NvimTreeFileDirty#" .. require("user.icons").ui.Circle .. "%*"
    value = value .. " " .. mod
  end

  if not f.is_empty(value) then
    local gps_value = get_gps()
    value = value .. " " .. gps_value
  end

  local num_tabs = #vim.api.nvim_list_tabpages()

  if num_tabs > 1 and not f.is_empty(value) then
    local tabpage_number = tostring(vim.api.nvim_tabpage_get_number(0))
    value = value .. "%=" .. tabpage_number .. "/" .. tostring(num_tabs)
  end

  local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
  if not status_ok then
    return
  end
end

M.create_winbar = function()
  vim.api.nvim_create_augroup("_winbar", {})
  if vim.fn.has "nvim-0.8" == 1 then
    vim.api.nvim_create_autocmd(
      { "CursorMoved", "CursorHold", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost", "TabClosed" },
      {
        group = "_winbar",
        callback = function()
          local status_ok, _ = pcall(vim.api.nvim_buf_get_var, 0, "lsp_floating_window")
          if not status_ok then
            require("user.winbar").get_winbar()
          end
        end,
      }
    )
  end
end

M.create_winbar()

return M
