local f = require "utils"
local icons = require "utils.icons"

local M = {}

local include_ft = { "help" }
local plugin_ft = {}
local show_conds = {}
local rename_conds = {}

M.add_include_ft = function(...)
  f.append_table(include_ft, ...)
end

M.add_plugin = function(...)
  f.append_table(plugin_ft, ...)
end

M.add_show_cond = function(cond)
  table.insert(show_conds, cond)
end

M.add_rename_cond = function(cond)
  table.insert(rename_conds, cond)
end

---@param hl_name string
---@param str string
---@return string
local function hl(hl_name, str)
  if f.is_empty(hl_name) then
    return str
  end
  return "%#" .. hl_name .. "#" .. str .. "%*"
end

---@return { file_icon: string, hl_icon: string, output_filename: string, hl_filename: string }
local function resolve_filename()
  local filename = vim.fn.expand "%:t"
  local full_filename = vim.fn.expand "%"
  local output_filename = vim.fn.expand "%:~:."
  local extension = vim.fn.expand "%:e"
  local ft = vim.bo.ft

  local file_icon = ""
  local hl_icon = "WinbarText"
  local hl_filename = "WinbarText"

  local ok, devicons = pcall(require, "nvim-web-devicons")
  if ok then
    file_icon, hl_icon = devicons.get_icon(filename, extension, { default = true })
  end

  if f.is_empty(filename) then
    output_filename = "[No Name]"
  end

  for _, cond in ipairs(rename_conds) do
    local result = cond { ft = ft, filename = filename, full_filename = full_filename }
    if result then
      return {
        file_icon = result.file_icon or file_icon,
        hl_icon = result.hl_icon or hl_icon,
        output_filename = result.output_filename or output_filename,
        hl_filename = result.hl_filename or hl_filename,
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

---@return boolean
local function should_show_winbar()
  local ft = vim.bo.filetype
  local full_filename = vim.fn.expand "%"

  if vim.tbl_contains(include_ft, ft) then
    return true
  end

  if vim.tbl_contains(plugin_ft, ft) then
    return false
  end

  for _, cond in ipairs(show_conds) do
    local result = cond { ft = ft, full_filename = full_filename }
    if result ~= nil then
      return result
    end
  end

  if not f.is_empty(vim.bo.buftype) then
    vim.opt_local.winbar = nil
    return false
  end

  return true
end

local function update_winbar()
  if vim.b.winbar_enabled == false then
    vim.opt_local.winbar = nil
    return
  end

  if not should_show_winbar() then
    return
  end

  local opts = resolve_filename()
  vim.opt_local.winbar = " " .. hl(opts.hl_icon, opts.file_icon) .. " " .. hl(opts.hl_filename, opts.output_filename)
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
    callback = update_winbar,
  })
end

return M
