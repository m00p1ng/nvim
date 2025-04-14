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

M.plugin_ft = {}

M.add_plugin_winbar = function(...)
  for _, v in ipairs { ... } do
    if type(v) == "table" then
      for j = 1, #v do
        M.plugin_ft[#M.plugin_ft + 1] = v[j]
      end
    else
      M.plugin_ft[#M.plugin_ft + 1] = v
    end
  end
end

local diffview_ft = {
  "DiffviewFiles",
  "DiffviewFileHistory",
}

local diffview_winbar = {
  " OURS (Current changes)",
  " THEIRS (Incoming changes)",
  " BASE (Common ancestor)",
  " LOCAL (Working tree)",
}

local function hl(hl_name, str)
  if f.is_empty(hl_name) then
    return str
  end

  return "%#" .. hl_name .. "#" .. str .. "%*"
end

local get_filename = function()
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

local use_local_winbar = function()
  local ft = vim.bo.filetype
  local full_filename = vim.fn.expand "%"

  if vim.tbl_contains(include_ft, ft) then
    return true
  end

  if vim.tbl_contains(M.plugin_ft, ft) then
    return false
  end

  for _, dw in ipairs(diffview_winbar) do
    if vim.startswith(vim.wo.winbar, dw) then
      return false
    end
  end

  -- diffview://null case
  if vim.startswith(full_filename, "diffview://") and not vim.tbl_contains(diffview_ft, ft) then
    return true
  end

  if vim.startswith(full_filename, "[CodeCompanion]") then
    return true
  end

  if not f.is_empty(vim.bo.buftype) then
    vim.opt_local.winbar = nil
    return false
  end

  return true
end

local get_winbar = function()
  if vim.b.winbar_enabled == false then
    vim.opt_local.winbar = nil
    return
  end

  if not use_local_winbar() then
    return
  end

  vim.opt_local.winbar = get_filename()
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
    callback = get_winbar,
  })
end

return M
