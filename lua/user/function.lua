local M = {}

local is_opened = false

function M.toggle_diffview()
  if is_opened == false then
    vim.cmd [[ DiffviewOpen ]]
  else
    vim.cmd [[ DiffviewClose ]]
  end
  is_opened = not is_opened
end

return M
