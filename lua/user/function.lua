local M = {}

function M.toggle_diffview()
  if vim.g.__diffview_opened == 0 then
    vim.cmd [[ DiffviewOpen ]]
  else
    vim.cmd [[ DiffviewClose ]]
  end
end

return M
