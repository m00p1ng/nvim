local f = require "utils"
local icons = require "utils.icons"

local M = {}

local include_ft = { "help" }
local plugin_ft = {}
local show_winbar_conds = {}
local rename_conds = {}

M.add_include_ft = function(...)
  f.append_table(include_ft, ...)
end

M.add_plugin = function(...)
  f.append_table(plugin_ft, ...)
end

M.add_show_cond = function(cond)
  table.insert(show_winbar_conds, cond)
end

M.add_rename_cond = function(cond)
  table.insert(rename_conds, cond)
end

local function hl(hl_name, str)
  if f.is_empty(hl_name) then
    return str
  end

  return "%#" .. hl_name .. "#" .. str .. "%*"
end

local _get_filename = function()
  local filename = vim.fn.expand "%:t"
  local full_filename = vim.fn.expand "%"
  local output_filename = vim.fn.expand "%:~:."
  local extension = vim.fn.expand "%:e"
  local ft = vim.bo.ft

  local file_icon = ""
  local hl_icon = "WinbarText"

  local ok, devicons = pcall(require, "nvim-web-devicons")
  if ok then
    file_icon, hl_icon = devicons.get_icon(filename, extension, { default = true })
  end

  local hl_filename = "WinbarText"

  if f.is_empty(filename) then
    output_filename = "[No Name]"
  end

  for _, cond in ipairs(rename_conds) do
    local c = cond {
      ft = ft,
      filename = filename,
      full_filename = full_filename,
    }

    if c ~= nil then
      return {
        file_icon = c.file_icon or file_icon,
        hl_icon = c.hl_icon or hl_icon,
        output_filename = c.output_filename or output_filename,
        hl_filename = c.hl_filename or hl_filename,
      }
    end
  end

  if ft == "help" then
    return {
      file_icon = icons.git.Repo,
      hl_icon = "WinbarModified",
      output_filename = "Help: " .. filename,
      hl_filename = hl_filename,
    }
  end

  if vim.bo.modified then
    return {
      file_icon = icons.ui.Circle,
      hl_icon = "WinbarModified",
      output_filename = output_filename,
      hl_filename = "WinbarModified",
    }
  end

  if vim.bo.readonly then
    return {
      file_icon = icons.ui.Lock,
      hl_icon = "WinbarModified",
      output_filename = output_filename,
      hl_filename = "LspDiagnosticsError",
    }
  end

  return {
    file_icon = file_icon,
    hl_icon = hl_icon,
    output_filename = output_filename,
    hl_filename = hl_filename,
  }
end

local get_filename = function()
  local opts = _get_filename()
  return " " .. hl(opts.hl_icon, opts.file_icon) .. " " .. hl(opts.hl_filename, opts.output_filename)
end

local use_local_winbar = function()
  local ft = vim.bo.filetype
  local full_filename = vim.fn.expand "%"

  if vim.tbl_contains(include_ft, ft) then
    return true
  end

  if vim.tbl_contains(plugin_ft, ft) then
    return false
  end

  for _, cond in ipairs(show_winbar_conds) do
    local c = cond {
      ft = ft,
      full_filename = full_filename,
    }
    if c ~= nil then
      return c
    end
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
