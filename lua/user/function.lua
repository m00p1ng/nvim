local M = {}

function M.clear_prompt()
  vim.api.nvim_command "normal! :<cr>"
end

function M.get_user_input_char()
  local c = vim.fn.getchar()
  while type(c) ~= "number" do
    c = vim.fn.getchar()
  end
  return vim.fn.nr2char(c)
end

function M.smart_quit(quit)
  local bufnr = vim.api.nvim_get_current_buf()
  local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
  if modified then
    print("You have unsaved changes. Quit anyway? (y/N) ")
    local input = M.get_user_input_char()

    if input == "y" then
      if quit == true then
        vim.cmd "q!"
      else
        vim.cmd "Bdelete!"
      end
    end

    M.clear_prompt()
  else
    if quit == true then
      vim.cmd "q!"
    else
      vim.cmd "Bdelete!"
    end
  end
end

function M.project_files(opts)
  local ok = pcall(require "telescope.builtin".git_files, opts)
  if not ok then require "telescope.builtin".find_files(opts) end
end

return M
