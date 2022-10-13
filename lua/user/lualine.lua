M = {}
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local lualine_scheme = "darkplus_dark"

local status_theme_ok, theme = pcall(require, "lualine.themes." .. lualine_scheme)
if not status_theme_ok then
  return
end

-- check if value in table
local function contains(t, value)
  for _, v in pairs(t) do
    if v == value then
      return true
    end
  end
  return false
end

local dark = "#181818"
local red = "#bf616a"
local blue = "#5e81ac"
local indent = "#A3BE8C"
local green = "#A3BE8C"
local cyan = "#88c0d0"
local orange = "#C68A75"
local yellow_orange = "#D7BA7D"
local purple = "#B48EAD"

vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#E8AB53", bg = dark })
vim.api.nvim_set_hl(0, "SLTermIcon", { fg = purple, bg = dark })
vim.api.nvim_set_hl(0, "SLBranchName", { fg = "#abb2bf", bg = dark, bold = false })
vim.api.nvim_set_hl(0, "SLLocation", { fg = blue, bg = dark })
vim.api.nvim_set_hl(0, "SLFT", { fg = cyan, bg = dark })
vim.api.nvim_set_hl(0, "SLIndent", { fg = indent, bg = dark })
vim.api.nvim_set_hl(0, "SLSeparator", { fg = "#6b727f", bg = dark, italic = true })
vim.api.nvim_set_hl(0, "SLError", { fg = red, bg = dark })
vim.api.nvim_set_hl(0, "SLWarning", { fg = yellow_orange, bg = dark })

local hl_str = function(str, hl)
  return "%#" .. hl .. "#" .. str
end

local mode_color = {
  n = blue,
  i = orange,
  v = "#b668cd",
  [""] = "#b668cd",
  V = "#b668cd",
  -- c = '#B5CEA8',
  -- c = '#D7BA7D',
  c = "#46a6b2",
  no = "#D16D9E",
  s = green,
  S = orange,
  [""] = orange,
  ic = red,
  R = "#D16D9E",
  Rv = red,
  cv = blue,
  ce = blue,
  r = red,
  rm = "#46a6b2",
  ["r?"] = "#46a6b2",
  ["!"] = "#46a6b2",
  t = red,
}

local hide_in_width = function()
  return vim.o.columns > 100
end

local icons = require "user.icons"

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
  function(str)
    return " "
  end,
  color = function()
    return { bg = mode_color[vim.fn.mode()], fg = 'NONE' }
  end,
  padding = 0,
}

local filetype = {
  "filetype",
  fmt = function(str)
    local ui_filetypes = require('user.function').ui_filetypes

    local return_val = function(str)
      return hl_str(str, "SLFT")
    end

    if str == "TelescopePrompt" then
      return return_val(icons.ui.Telescope)
    end

    local function get_term_num()
      local t_status_ok, toggle_num = pcall(vim.api.nvim_buf_get_var, 0, "toggle_number")
      if not t_status_ok then
        return ""
      end
      return toggle_num
    end

    if str == "toggleterm" then
      local term = "%#SLTermIcon#" .. " " .. "%#SLFT#" .. get_term_num()

      return return_val(term)
    end

    if contains(ui_filetypes, str) or str == "" then
      return ""
    else
      return return_val(str)
    end
  end,
  icons_enabled = false,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "%#SLGitIcon#" .. "" .. "%*" .. "%#SLBranchName#",
  colored = false,
  fmt = function(str)
    if str == "" or str == nil then
      return "[unknown]"
    end

    local max_length = 30
    if str:len() > max_length then
      return str:sub(1, max_length) .. "..."
    end

    return str
  end,
  on_click = function ()
    vim.cmd ":Telescope git_branches"
  end,
}

local current_signature = {
  function()
    local buf_ft = vim.bo.filetype

    if buf_ft == "toggleterm" or buf_ft == "TelescopePrompt" then
      return ""
    end
    if not pcall(require, "lsp_signature") then
      return ""
    end
    local sig = require("lsp_signature").status_line(30)
    local hint = sig.hint

    if hint ~= nil and hint ~= "" then
      return "%#SLSeparator# " .. hint
    end

    return ""
  end,
  cond = hide_in_width,
}

local spaces = {
  function()
    local buf_ft = vim.bo.filetype

    local ui_filetypes = require('user.function').ui_filetypes

    if contains(ui_filetypes, buf_ft) then
      return ""
    end

    local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")

    if shiftwidth == nil then
      return ""
    end

    -- TODO: update codicons and use their indent
    return hl_str(" " .. shiftwidth, "SLIndent")
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
    local ui_filetypes = require('user.function').ui_filetypes

    if contains(ui_filetypes, buf_ft) then
      return ""
    end

    local size = vim.fn.wordcount().bytes

    local suffixes = { 'B', 'KB', 'MB', 'GB' }

    local i = 1
    while size > 1024 and i < #suffixes do
      size = size / 1024
      i = i + 1
    end

    local format = i == 1 and '%d%s' or '%.1f%s'
    return string.format(format, size, suffixes[i])
  end,
}

lualine.setup {
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = theme,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { mode, branch },
    lualine_b = { diagnostics },
    lualine_c = { current_signature },
    lualine_x = { filesize },
    lualine_y = { spaces, filetype },
    lualine_z = { location },
  },
  tabline = {},
  winbar = {},
  extensions = {},
}
