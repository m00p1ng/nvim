local f = require "utils"
local icons = require "utils.icons"

local M = {}

local dap_icons = {
  dapui_breakpoints = icons.ui.Bug,
  dapui_stacks = icons.ui.Stacks,
  dapui_scopes = icons.ui.Scopes,
  dapui_watches = icons.ui.Watches,
  dapui_console = icons.ui.Terminal,
}

local include_ft = {
  "dapui_breakpoints",
  "dapui_scopes",
  "dapui_stacks",
  "dapui_watches",
  "dapui_console",
  "help",
}

local diffview_ft = {
  "DiffviewFiles",
  "DiffviewFilesHistory",
}

local function hl(hl_name, str)
  if f.is_empty(hl_name) then
    return str
  end

  return "%#" .. hl_name .. "#" .. str .. "%*"
end

M.get_filename = function()
  local filename = vim.fn.expand "%:t"
  local full_filename = vim.fn.expand "%"
  local output_filename = vim.fn.expand "%:~:."
  local extension = vim.fn.expand "%:e"
  local ft = vim.bo.ft

  local file_icon, hl_icon = require("nvim-web-devicons").get_icon(filename, extension, { default = true })
  local hl_filename = "WinbarText"

  if f.is_empty(filename) then
    output_filename = "[No Name]"
  end

  if vim.startswith(full_filename, "diffview") then
    local paths = vim.split(full_filename, ".git", { plain = true })
    if #paths >= 2 then
      filename = paths[2]
      output_filename = "diffview:/" .. filename
    end
  end

  if vim.startswith(filename, "DAP") then
    file_icon = vim.tbl_get(dap_icons, ft) or ""
    output_filename = vim.split(filename, " ")[2]
  elseif ft == "help" then
    hl_icon = "WinbarModified"
    file_icon = icons.git.Repo
    output_filename = "Help: " .. filename
  elseif vim.bo.modified then
    hl_filename = "WinbarModified"
    hl_icon = "WinbarModified"
    file_icon = icons.ui.Circle
  elseif vim.bo.readonly then
    hl_filename = "LspDiagnosticsError"
    hl_icon = "WinbarModified"
    file_icon = icons.ui.Lock
  end

  return " " .. hl(hl_icon, file_icon) .. " " .. hl(hl_filename, output_filename)
end

local excludes = function()
  local ft = vim.bo.filetype
  local full_filename = vim.fn.expand "%"

  if vim.tbl_contains(include_ft, ft) then
    return false
  end
  --
  -- diffview://null case
  if vim.startswith(full_filename, "diffview://") and not vim.tbl_contains(diffview_ft, ft) then
    return false
  end

  if not f.is_empty(vim.bo.buftype) then
    vim.opt_local.winbar = nil
    return true
  end
  return false
end

M.get_winbar = function()
  if vim.b.winbar_enabled == false then
    vim.opt_local.winbar = nil
    return
  end

  -- do not replace application winbar
  if not vim.b.has_local_winbar and not f.is_empty(vim.wo.winbar) then
    return
  end

  if excludes() then
    return
  end

  vim.b.has_local_winbar = true
  vim.opt_local.winbar = M.get_filename()
end

M.create_winbar = function()
  vim.api.nvim_create_autocmd({
    "CursorMoved",
    "CursorMovedI",
    "CursorHold",
    "BufWinEnter",
    "BufFilePost",
    "BufRead",
    "BufWritePost",
    "TabClosed",
  }, {
    group = vim.api.nvim_create_augroup("_winbar", {}),
    callback = M.get_winbar,
  })
end

return M
