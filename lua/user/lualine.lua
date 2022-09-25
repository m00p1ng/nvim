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

local gray = "#32363e"
local dark_gray = "#282C34"
local red = "#D16969"
local blue = "#569CD6"
local green = "#6A9955"
local cyan = "#4EC9B0"
local orange = "#CE9178"
local indent = "#CE9178"
local yellow = "#DCDCAA"
local yellow_orange = "#D7BA7D"
local purple = "#C586C0"

if lualine_scheme == "darkplus_dark" then
  gray = "#303030"
  dark_gray = "#303030"
  red = "#bf616a"
  blue = "#5e81ac"
  indent = "#A3BE8C"
  green = "#A3BE8C"
  cyan = "#88c0d0"
  orange = "#C68A75"
  yellow = "#DCDCAA"
  yellow_orange = "#D7BA7D"
  purple = "#B48EAD"
end

local sl_hl = vim.api.nvim_get_hl_by_name("StatusLine", true)
local sl_hl_sep = vim.api.nvim_get_hl_by_name("StatusLineSeparator", true)

vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#E8AB53", bg = dark_gray })
vim.api.nvim_set_hl(0, "SLTermIcon", { fg = purple, bg = gray })
vim.api.nvim_set_hl(0, "SLBranchName", { fg = "#abb2bf", bg = dark_gray, bold = false })
vim.api.nvim_set_hl(0, "SLProgress", { fg = purple, bg = gray })
vim.api.nvim_set_hl(0, "SLLocation", { fg = blue, bg = gray })
vim.api.nvim_set_hl(0, "SLSize", { fg = "#cccccc", bg = gray })
vim.api.nvim_set_hl(0, "SLFT", { fg = cyan, bg = gray })
vim.api.nvim_set_hl(0, "SLIndent", { fg = indent, bg = gray })
vim.api.nvim_set_hl(0, "SLLSP", { fg = "#6b727f", bg = "NONE" })
vim.api.nvim_set_hl(0, "SLSep", { fg = gray, bg = "NONE" })
vim.api.nvim_set_hl(0, "SLFG", { fg = "#abb2bf", bg = "NONE" })
vim.api.nvim_set_hl(0, "SLSeparator", { fg = "#6b727f", bg = "NONE", italic = true })
vim.api.nvim_set_hl(0, "SLError", { fg = "#bf616a", bg = "NONE" })
vim.api.nvim_set_hl(0, "SLWarning", { fg = "#D7BA7D", bg = "NONE" })
vim.api.nvim_set_hl(0, "SLWarningGit", { fg = "#D7BA7D", bg = dark_gray })
vim.api.nvim_set_hl(0, "SLCopilot", { fg = "#6CC644", bg = "NONE" })

local hl_str = function(str, hl)
  return "%#" .. hl .. "#" .. str .. "%*"
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

local left_pad = {
  function()
    return " "
  end,
  padding = 0,
  color = function()
    return { fg = gray }
  end,
}

local right_pad = {
  function()
    return " "
  end,
  padding = 0,
  color = function()
    return { fg = dark_gray }
  end,
}

local left_pad_alt = {
  function()
    return " "
  end,
  padding = 0,
  color = function()
    return { fg = gray }
  end,
}

local right_pad_alt = {
  function()
    return " "
  end,
  padding = 0,
  color = function()
    return { fg = gray }
  end,
}

local hide_in_width = function()
  return vim.o.columns > 80
end

local hide_in_width_100 = function()
  return vim.o.columns > 100
end

local icons = require "user.icons"

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = {
    error = "%#SLError#" .. icons.diagnostics.Error .. "%*" .. " ",
    warn = "%#SLWarning#" .. icons.diagnostics.Warning .. "%*" .. " ",
  },
  colored = false,
  update_in_insert = false,
  always_visible = true,
  padding = 0,
}

local mode = {
  function()
    return " "
  end,
  color = function()
    -- auto change color according to neovims mode
    return { fg = mode_color[vim.fn.mode()], bg = gray }
  end,
  padding = 0,
}

local filetype = {
  "filetype",
  fmt = function(str)
    local ui_filetypes = {
      "help",
      "packer",
      "NeogitStatus",
      "NeogitPopup",
      "NeogitCommitMessage",
      "DiffviewFiles",
      "Outline",
      "NvimTree",
      "qf",
      "toggleterm",
      "",
      "nil",
    }

    local return_val = function(str)
      return hl_str(" ", "SLSep") .. hl_str(str, "SLFT") .. hl_str("", "SLSep")
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
      local term = "%#SLTermIcon#" .. " " .. "%*" .. "%#SLFT#" .. get_term_num() .. "%*"

      return return_val(term)
    end

    if contains(ui_filetypes, str) then
      return ""
    else
      return return_val(str)
    end
  end,
  icons_enabled = false,
  padding = 0,
}
local filename = {
  "filename",
  fmt = function(str)
    local buf_ft = vim.bo.filetype
    local ui_filetypes = {
      "help",
      "packer",
      "NeogitStatus",
      "NeogitPopup",
      "NvimTree",
      "qf",
      "toggleterm",
      "Outline",
      "",
      "nil",
    }

    if contains(ui_filetypes, buf_ft) then
      return ""
    end

    return str
  end,
  file_status = true,
  path = 1,
  shorting_target = 50,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "%#SLGitIcon#" .. " " .. "%*" .. "%#SLBranchName#",
  colored = false,
  padding = 0,
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
}

local progress = {
  "progress",
  fmt = function(str)
    -- return "▊"
    return hl_str("", "SLSep") .. hl_str("%P/%L", "SLProgress") .. hl_str(" ", "SLSep")
    -- return "  "
  end,
  -- color = "SLProgress",
  padding = 0,
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
      return "%#SLSeparator# " .. hint .. "%*"
    end

    return ""
  end,
  cond = hide_in_width_100,
  padding = 0,
}

local spaces = {
  function()
    local buf_ft = vim.bo.filetype

    local ui_filetypes = {
      "help",
      "packer",
      "NeogitStatus",
      "NeogitPopup",
      "NeogitCommitMessage",
      "NvimTree",
      "qf",
      "Outline",
      "DiffviewFiles",
      "",
    }

    if contains(ui_filetypes, buf_ft) then
      return ""
    end

    local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")

    if shiftwidth == nil then
      return ""
    end

    -- TODO: update codicons and use their indent
    return hl_str("", "SLSep") .. hl_str(" " .. shiftwidth, "SLIndent") .. hl_str("", "SLSep")
  end,
  padding = 0,
}

local language_server = {
  function()
    local buf_ft = vim.bo.filetype
    local ui_filetypes = {
      "help",
      "packer",
      "NeogitStatus",
      "NeogitPopup",
      "NvimTree",
      "qf",
      "toggleterm",
      "TelescopePrompt",
      "lspinfo",
      "",
    }

    if contains(ui_filetypes, buf_ft) then
      if M.language_servers == nil then
        return ""
      else
        return M.language_servers
      end
    end

    local clients = vim.lsp.buf_get_clients()
    local client_names = {}

    -- add client
    for _, client in pairs(clients) do
      if client.name ~= "null-ls" then
        table.insert(client_names, client.name)
      end
    end

    -- join client names with commas
    local client_names_str = table.concat(client_names, ", ")

    -- check client_names_str if empty
    local language_servers = ""
    local client_names_str_len = #client_names_str
    if client_names_str_len ~= 0 then
      language_servers = hl_str("", "SLSep") .. hl_str(client_names_str, "SLSeparator") .. hl_str("", "SLSep")
    end

    if client_names_str_len == 0 then
      return ""
    else
      M.language_servers = language_servers
      return language_servers:gsub(", anonymous source", "")
    end
  end,
  padding = 0,
  cond = hide_in_width,
}

local location = {
  "location",
  fmt = function(str)
    return hl_str(" ", "SLSep") .. hl_str(str, "SLLocation") .. hl_str(" ", "SLSep")
  end,
  padding = 0,
}

local filesize = {
  function()
    local buf_ft = vim.bo.filetype
    local ui_filetypes = {
      "help",
      "packer",
      "NeogitStatus",
      "NeogitPopup",
      "NeogitCommitMessage",
      "NvimTree",
      "qf",
      "toggleterm",
      "DiffviewFiles",
      "TelescopePrompt",
      "Outline",
      "",
      "nil",
    }

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
    return hl_str("", "SLSep") .. hl_str(string.format(format, size, suffixes[i]), "SLSize") .. hl_str("", "SLSep")
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
    lualine_a = { left_pad, mode, branch, right_pad },
    lualine_b = { left_pad_alt, diagnostics, right_pad_alt },
    lualine_c = { filename },
    lualine_x = { language_server, filesize },
    lualine_y = { spaces, filetype },
    lualine_z = { location },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
}
