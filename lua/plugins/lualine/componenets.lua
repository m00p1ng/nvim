---@diagnostic disable: undefined-field
M = {}

local f = require "utils"
local dark = "#181825"

vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#fab387", bg = dark })
vim.api.nvim_set_hl(0, "SLBranchName", { fg = "#bac2de", bg = dark, bold = false })
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
  n = "#8caaee",
  i = "#a6d189",
  v = "#ca9ee6",
  [""] = "#ca9ee6",
  V = "#ca9ee6",
  c = "#ef9f76",
  no = "#8caaee",
  s = "#a6d189",
  S = "#ef9f76",
  [""] = "#ef9f76",
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
    error = "%#SLError#" .. icons.diagnostics.Error .. " ",
    warn = "%#SLWarning#" .. icons.diagnostics.Warning .. " ",
  },
  colored = false,
  update_in_insert = false,
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

    return hl_str(str, "SLFiletype")
  end,
  icons_enabled = false,
  cond = function()
    local ft = vim.bo.ft
    return not f.is_ui_filetype(ft)
  end,
}

local cached_branch = ""
M.branch = {
  "branch",
  icons_enabled = true,
  icon = "%#SLGitIcon#" .. icons.git.Branch .. "%*" .. "%#SLBranchName#",
  colored = false,
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
    local shiftwidth = vim.bo.shiftwidth
    if shiftwidth == nil then
      return ""
    end

    return hl_str(icons.ui.Tab .. " " .. shiftwidth, "SLIndent")
  end,
  cond = function()
    local ft = vim.bo.ft
    return not f.is_ui_filetype(ft)
  end,
}

M.location = {
  "location",
  color = function()
    return { fg = get_mode_color(), bg = dark }
  end,
}

M.progress = {
  "progress",
  color = function()
    return { fg = dark, bg = get_mode_color(), gui = "bold" }
  end,
}

M.filesize = {
  function()
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
  cond = function()
    local ft = vim.bo.ft
    return not f.is_ui_filetype(ft)
  end,
}

M.tabs = {
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
  color = { fg = "#eba0ac" },
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

    if not f.is_empty(hint) then
      return "%#SLSeparator# " .. hint .. "%*"
    end

    return ""
  end,
  padding = 0,
  cond = function()
    local ft = vim.bo.ft
    return not f.is_ui_filetype(ft)
  end,
}

return M
