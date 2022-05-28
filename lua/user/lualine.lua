local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 0
end

local icons = require "user.icons"

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = icons.diagnostics.Error .. " ", warn = icons.diagnostics.Warning .. " " },
  colored = false,
  update_in_insert = false,
  always_visible = true,
  cond = hide_in_width,
}

local mode = {
  "mode",
  fmt = function(str)
    return str:sub(1, 1)
  end,
  cond = hide_in_width,
}

local filetype = {
  "filetype",
  icons_enabled = false,
  icon = nil,
  cond = hide_in_width,
}

local filename = {
  "filename",
  file_status = true,
  path = 1,
  shorting_target = 50,
}

local branch = {
  "branch",
  fmt = function(str)
    local max_length = 30
    if str:len() > max_length then
      return str:sub(1, max_length) .. "..."
    end

    return str
  end,
  icons_enabled = true,
  icon = "",
  cond = hide_in_width,
}

-- cool function for progress
local progress = {
  'progress'
}

local filesize = {
  function()
    local size = vim.fn.wordcount().bytes

    local suffixes = { 'B', 'KB', 'MB', 'GB' }

    local i = 1
    while size > 1024 and i < #suffixes do
      size = size / 1024
      i = i + 1
    end

    local format = i == 1 and 'size: %d%s' or 'size: %.2f%s'
    return string.format(format, size, suffixes[i])
  end,
  cond = hide_in_width,
}

lualine.setup {
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    -- disabled_filetypes = { "alpha", "NvimTree", "DiffviewFiles" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { branch, diagnostics },
    lualine_b = { mode, filename },
    lualine_c = {},
    lualine_x = { filesize, filetype },
    lualine_y = { "location" },
    lualine_z = { progress },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { filename },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
}
