local M = require("lualine.component"):extend()
local icons = require "utils.icons"

M.processing = false
M.spinner_index = 1

-- Breathing color palette: dim → bright → dim (base: #e5c890)
local breathing_colors = {
  "#5c4a20",
  "#a68840",
  "#e5c890",
  "#f2e0b8",
  "#e5c890",
  "#a68840",
}
local spinner_length = #breathing_colors

local function setup_breathing_highlights()
  for i, color in ipairs(breathing_colors) do
    vim.api.nvim_set_hl(0, "CodeCompanionBreathing" .. i, { fg = color })
  end
end

-- Initializer
function M:init(options)
  M.super.init(self, options)

  setup_breathing_highlights()

  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = setup_breathing_highlights,
  })

  local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "CodeCompanionRequest*",
    group = group,
    callback = function(request)
      if request.match == "CodeCompanionRequestStarted" then
        self.processing = true
      elseif request.match == "CodeCompanionRequestFinished" then
        self.processing = false
      end
    end,
  })
end

-- Function that runs every time statusline is updated
function M:update_status()
  if self.processing then
    self.spinner_index = (self.spinner_index % spinner_length) + 1

    local hl = "CodeCompanionBreathing" .. self.spinner_index
    return "%#" .. hl .. "#" .. icons.ai.Robot .. "%*"
  else
    return nil
  end
end

return M
