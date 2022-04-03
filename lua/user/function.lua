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

M.project_files = function(opts)
  local ok = pcall(require"telescope.builtin".git_files, opts)
  if not ok then require"telescope.builtin".find_files(opts) end
end

return M
