local f = require "utils"
local icons = require "utils.icons"

local M = {}

local dap_icons = {
  dapui_breakpoints = icons.ui.Bug,
  dapui_stacks = icons.ui.Stacks,
  dapui_scopes = icons.ui.Scopes,
  dapui_watches = icons.ui.Watches,
}

local extra_includes = {
  "dapui_breakpoints",
  "dapui_scopes",
  "dapui_stacks",
  "dapui_watches",
}

M.get_filename = function()
  local filename = vim.fn.expand "%:t"
  local full_filename = vim.fn.expand "%"
  local output_filename = vim.fn.expand "%:~:."
  local extension = vim.fn.expand "%:e"
  local ft = vim.bo.filetype

  if f.is_empty(filename) then
    return "%#NavicText#" .. " " .. icons.kind.File .. " " .. "[No Name]"
  end

  local file_icon, file_icon_color =
    require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })

  local hl_group = "FileIconColor" .. extension

  vim.api.nvim_set_hl(0, hl_group, { fg = file_icon_color })
  if f.is_empty(file_icon) then
    file_icon = icons.kind.File
    file_icon_color = ""
  end

  if vim.startswith(filename, "DAP") then
    file_icon = vim.tbl_get(dap_icons, ft) or ""
    file_icon_color = ""
    output_filename = vim.split(filename, " ")[2]
  end

  if vim.startswith(full_filename, "diffview") then
    local paths = vim.split(full_filename, ".git", { plain = true })
    if #paths >= 2 then
      filename = paths[2]
      output_filename = "diffview:/" .. filename
    end
  end

  local hl_filename = ""
  if f.get_buf_option "modified" then
    hl_filename = "%#WinbarModified#"
    file_icon = "%#WinbarModified#" .. icons.ui.Circle .. "%*"
  elseif f.get_buf_option "readonly" then
    hl_filename = "%#LspDiagnosticsSignError#"
    file_icon = "%#WinbarModified#" .. icons.ui.Lock .. "%*"
  else
    hl_filename = "%#NavicText#"
  end

  return " " .. "%#" .. hl_group .. "#" .. file_icon .. "%*" .. " " .. hl_filename .. output_filename .. "%*"
end

local get_location = function()
  local navic = require "nvim-navic"
  if not navic.is_available() then
    return ""
  end

  local location = navic.get_location()
  if f.is_empty(location) then
    return ""
  end

  return "%#NavicSeparator#" .. icons.ui.ChevronShortRight .. "%*" .. " " .. location
end

local excludes = function()
  local ft = vim.bo.filetype
  local full_filename = vim.fn.expand "%"

  local exclude_filetypes = {
    "dap-repl",
    "oil",
  }

  if vim.tbl_contains(exclude_filetypes, ft) or full_filename == "__FLUTTER_DEV_LOG__" then
    return true
  end

  if vim.tbl_contains(extra_includes, ft) then
    return false
  end

  local buf_number = vim.api.nvim_get_current_buf()
  if 1 == vim.fn.buflisted(buf_number) and ft ~= "NeogitCommitMessage" and ft ~= "NeogitCommitPopup" then
    return false
  end

  -- diffview://null case
  if ft == "" and vim.startswith(full_filename, "diffview://") then
    return false
  end

  if f.is_ui_filetype(ft) then
    vim.opt_local.winbar = nil
    return true
  end
  return false
end

M.get_winbar = function()
  if excludes() then
    return
  end
  local value = M.get_filename()

  if not f.is_empty(value) then
    local gps_value = get_location()
    value = value .. " " .. gps_value .. "%<"
  end

  pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
end

M.create_winbar = function()
  vim.api.nvim_create_autocmd({
    "CursorMoved",
    "CursorMovedI",
    "CursorHold",
    "BufWinEnter",
    "BufFilePost",
    "BufRead",
    "InsertEnter",
    "BufWritePost",
    "TabClosed",
  }, {
    group = vim.api.nvim_create_augroup("_winbar", {}),
    callback = M.get_winbar,
  })
end

return M
