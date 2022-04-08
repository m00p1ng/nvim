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

function M.toggle_diffview_file_history()
  if is_opened == false then
    vim.cmd [[ DiffviewFileHistory ]]
  else
    vim.cmd [[ DiffviewClose ]]
  end
  is_opened = not is_opened
end

function M.project_files(opts)
  local ok = pcall(require"telescope.builtin".git_files, opts)
  if not ok then require"telescope.builtin".find_files(opts) end
end

function M.init_spelunker()
  local filetype = vim.api.nvim_buf_get_option(0, 'ft')
  if vim.tbl_contains(vim.g.spelunker_ignored_filetypes, filetype) then
      return
  end

  vim.cmd [[
    call spelunker#check_displayed_words()
  ]]
end

return M
