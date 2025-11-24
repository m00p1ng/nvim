---@diagnostic disable: undefined-field
M = {}

local f = require "utils"

-- https://github.com/nvim-lualine/lualine.nvim/blob/2a5bae925481f999263d6f5ed8361baef8df4f83/lua/lualine/utils/mode.lua
local mode_color = {
  n = "#8caaee",
  i = "#a6d189",
  v = "#ca9ee6",
  ["\22"] = "#ca9ee6",
  V = "#ca9ee6",
  c = "#ef9f76",
  no = "#8caaee",
  s = "#a6d189",
  S = "#ef9f76",
  ["\19"] = "#ef9f76",
  ic = "#a6d189",
  R = "#e78284",
  Rv = "#e78284",
  cv = "#ef9f76",
  ce = "#ef9f76",
  r = "#e78284",
  rm = "#85c1dc",
  ["r?"] = "#85c1dc",
  ["!"] = "#85c1dc",
  t = "#a6d189",
}

local icons = require "utils.icons"

local function get_mode_color()
  local mode = vim.fn.mode()
  return mode_color[mode]
end

M.diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = {
    error = icons.diagnostics.Error .. " ",
    warn = icons.diagnostics.Warning .. " ",
  },
  update_in_insert = true,
  always_visible = true,
}

M.mode = {
  function()
    return "▌"
  end,
  color = function()
    return { fg = get_mode_color(), bg = "NONE" }
  end,
  padding = 0,
}

M.filetype = {
  "filetype",
  fmt = function(str)
    if str == "" then
      return ""
    end

    return str
  end,
  icons_enabled = true,
  cond = function()
    return not f.is_ui_filetype(vim.bo.ft)
  end,
  color = { fg = "#85c1dc" },
}

local cached_branch = ""
M.branch = {
  "branch",
  icons_enabled = true,
  icon = { icons.git.Branch, color = { fg = "#ef9f76" } },
  fmt = function(str)
    if str == "" or str == nil then
      if cached_branch == "" then
        return "[unknown]"
      end

      return cached_branch
    end

    cached_branch = str
    local max_length = 30
    if #cached_branch > max_length then
      cached_branch = cached_branch:sub(1, max_length) .. "…"
    end

    return cached_branch
  end,
}

M.spaces = {
  function()
    local prefix = ""
    if vim.bo.expandtab then
      prefix = icons.ui.Space
    else
      prefix = icons.ui.Tab
    end
    return ("%s %s"):format(prefix, vim.bo.shiftwidth)
  end,
  cond = function()
    return not f.is_ui_filetype(vim.bo.ft) and not f.is_empty(vim.bo.shiftwidth)
  end,
  color = { fg = "#a6d189" },
}

M.location = {
  "location",
  color = function()
    return { fg = get_mode_color() }
  end,
}

M.progress = {
  "progress",
  color = function()
    return { fg = "#232634", bg = get_mode_color(), gui = "bold" }
  end,
}

M.filesize = {
  "filesize",
  cond = function()
    return not f.is_ui_filetype(vim.bo.ft)
  end,
  color = { fg = "#949cbb" },
}

M.tabs = {
  "tabs",
  tabs_color = {
    active = { fg = "#a6d189", bg = "#292c3d", gui = "bold" },
    inactive = { fg = "#292c3d", bg = "#000000" },
  },
  cond = function()
    return #vim.api.nvim_list_tabpages() > 1
  end,
}

-- recording @q
M.status_mode = {
  require("noice").api.status.mode.get,
  cond = require("noice").api.status.mode.has,
}

M.search_result = {
  require("noice").api.status.search.get,
  cond = require("noice").api.status.search.has,
}

M.command = {
  require("noice").api.status.command.get,
  cond = require("noice").api.status.command.has,
  color = { fg = "#ea999c" },
}

M.autoformat = {
  function()
    if not vim.g.autoformat then
      return "G"
    end

    if vim.b.autoformat ~= nil and not vim.b.autoformat then
      return "B"
    end
  end,
  icon = "󱏟",
  cond = function()
    return not vim.g.autoformat or (vim.b.autoformat ~= nil and not vim.b.autoformat)
  end,
}

M.updated_plugin = {
  require("lazy.status").updates,
  cond = require("lazy.status").has_updates,
  color = { fg = "Special", bg = "NONE" },
}

M.current_signature = {
  function()
    local sig = require("lsp_signature").status_line(30)
    local hint = sig.hint

    if f.is_empty(hint) then
      return ""
    end

    return hint
  end,
  cond = function()
    return not f.is_ui_filetype(vim.bo.ft)
  end,
  color = { fg = "#626880" },
}

M.copilot = {
  function()
    local c = require "copilot.client"
    local s = require "copilot.status"
    if c.is_disabled() then
      return icons.misc.CopilotDisabled
    elseif s.data.status == "Warning" then
      return icons.misc.CopilotWarning
    end

    return ""
  end,
  cond = function()
    local has_copilot, _ = pcall(require, "copilot.client")
    return has_copilot
  end,
  color = { fg = "#f38ba8" },
}

return M
