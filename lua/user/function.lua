local M = {}

local is_opened = false

function M.open_diffview()
  vim.cmd [[ DiffviewOpen ]]
  is_opened = true
end

function M.open_diffview_file_history()
  vim.cmd [[ DiffviewFileHistory ]]
  is_opened = true
end

function M.close_diffview()
  vim.cmd [[ DiffviewClose ]]
  vim.cmd [[ NvimTreeRefresh ]]
  is_opened = false
end

function M.toggle_diffview()
  if is_opened == false then
    M.open_diffview()
  else
    M.close_diffview()
  end
end

function M.toggle_diffview_file_history()
  if is_opened == false then
    M.open_diffview_file_history()
  else
    M.close_diffview()
  end
end

function M.project_files(opts)
  local ok = pcall(require"telescope.builtin".git_files, opts)
  if not ok then require"telescope.builtin".find_files(opts) end
end

return M
