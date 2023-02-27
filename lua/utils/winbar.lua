local f = require "utils"
local icons = require "utils.icons"

local M = {}

M.get_filename = function()
  local filename = vim.fn.expand "%:t"
  local extension = vim.fn.expand "%:e"

  if not f.is_empty(filename) then
    local file_icon, file_icon_color =
      require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })

    local hl_group = "FileIconColor" .. extension

    vim.api.nvim_set_hl(0, hl_group, { fg = file_icon_color })
    if f.is_empty(file_icon) then
      file_icon = icons.kind.File
      file_icon_color = ""
    end

    if vim.startswith(filename, "DAP") then
      file_icon = icons.ui.Bug
      file_icon_color = ""
    end

    local hl_filename = ""
    if f.get_buf_option "modified" then
      hl_filename = "%#NvimTreeFileDirty#"
      file_icon = "%#NvimTreeFileDirty#" .. icons.ui.Circle .. "%*"
    elseif f.get_buf_option "readonly" then
      hl_filename = "%#LspDiagnosticsSignError#"
      file_icon = "%#NvimTreeFileDirty#" .. icons.ui.Lock .. "%*"
    else
      hl_filename = "%#NavicText#"
    end

    return " " .. "%#" .. hl_group .. "#" .. file_icon .. "%*" .. " " .. hl_filename .. vim.fn.expand "%:~:." .. "%*"
  end

  local buf_number = vim.api.nvim_buf_get_number(0)
  if 1 == vim.fn.buflisted(buf_number) then
    return "%#NavicText#" .. " " .. icons.kind.File .. " " .. "[No Name]"
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

  if not f.is_empty(gps_location) then
    return "%#NavicSeparator#" .. icons.ui.ChevronRight .. "%*" .. " " .. gps_location
  else
    return ""
  end
end

local excludes = function()
  local filetype = vim.bo.filetype
  local winbar_filetype_exclude = f.ui_filetypes

  local extra_includes = {
    "dapui_hover",
    "dap-repl",
  }

  if vim.tbl_contains(extra_includes, filetype) then
    return true
  end

  if vim.startswith(filetype, "dap") then
    return false
  end

  if vim.tbl_contains(winbar_filetype_exclude, filetype) then
    local extension = vim.fn.expand "%:e"

    if extension == "" then
      vim.opt_local.winbar = nil
      return true
    else
      return false
    end
  end
  return false
end

M.get_winbar = function()
  if excludes() then
    return
  end
  local value = M.get_filename()

  if not f.is_empty(value) then
    local gps_value = get_gps()
    value = value .. " " .. gps_value .. "%<"
  end

  local bufnrs = f.get_buf_list()
  local cur_buf = vim.api.nvim_get_current_buf()
  local num_bufs = #bufnrs

  if num_bufs > 1 and 1 == vim.fn.buflisted(cur_buf) and not f.is_empty(value) then
    local buf_idx = f.find_index(bufnrs, cur_buf)

    if buf_idx ~= nil then
      value = value .. "%=" .. "%#Normal#" .. tostring(buf_idx) .. "/" .. tostring(num_bufs)
    end
  end

  local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
  if not status_ok then
    return
  end
end

M.create_winbar = function()
  vim.api.nvim_create_augroup("_winbar", {})
  vim.api.nvim_create_autocmd({
    "CursorMoved",
    "CursorMovedI",
    "CursorHold",
    "BufWinEnter",
    -- "BufFilePost",
    -- "InsertEnter",
    -- "BufWritePost",
    -- "TabClosed",
  }, {
    group = "_winbar",
    callback = function()
      local status_ok, _ = pcall(vim.api.nvim_buf_get_var, 0, "lsp_floating_window")
      if not status_ok then
        M.get_winbar()
      end
    end,
  })
end

M.create_winbar()

return M
