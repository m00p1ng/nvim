local M = {}

M.ui_filetypes = {
  "alpha",
  "NvimTree",
  "help",
  "packer",
  "NeogitStatus",
  "NeogitPopup",
  "NeogitCommitPopup",
  "NeogitCommitMessage",
  "DiffviewFiles",
  "DiffviewFileHistory",
  "Outline",
  "qf",
  "toggleterm",
  "TelescopePrompt",
  "lspinfo",
  "mason",
  "dapui_watches",
  "dapui_stacks",
  "dapui_breakpoints",
  "dapui_scopes",
  "dapui_hover",
  "dap-repl",
  "neotest-summary",
  "CompetiTest",
}

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

function M.is_empty(s)
  return s == nil or s == ""
end

function M.get_buf_option(opt)
  local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
  if not status_ok then
    return nil
  else
    return buf_option
  end
end

function M.project_files(opts)
  local ok = pcall(require "telescope.builtin".git_files, opts)
  if not ok then require "telescope.builtin".find_files(opts) end
end

function M.git_previous_change()
  require "gitblame".copy_sha_to_clipboard()
  local sha = vim.fn.getreg('+')
  vim.api.nvim_command(':DiffviewOpen ' .. sha .. '^!')
end

function M.git_open_web()
  require "gitblame".copy_sha_to_clipboard()
  local sha = vim.fn.getreg('+')

  local parse_git_url = function(remote_url)
    local commit_path = '/commit/' .. sha

    local domain, path = string.match(remote_url, ".*git%@(.*)%:(.*)%.git")
    if domain and path then return 'https://' .. domain .. '/' .. path .. commit_path end

    local url = string.match(remote_url, ".*git%@(.*)%.git")
    if url then return 'https://' .. url .. commit_path end

    local https_url = string.match(remote_url, "(https%:%/%/.*)%.git")
    if https_url then return https_url .. commit_path end

    -- Don't have .git extension
    domain, path = string.match(remote_url, ".*git%@(.*)%:(.*)")
    if domain and path then return 'https://' .. domain .. '/' .. path .. commit_path end

    url = string.match(remote_url, ".*git%@(.*)")
    if url then return 'https://' .. url .. commit_path end

    https_url = string.match(remote_url, "(https%:%/%/.*)")
    if https_url then return https_url .. commit_path end
  end

  require "gitblame.git".get_remote_url(function(remote_url)
    local url = parse_git_url(remote_url)
    require "gitblame.utils".launch_url(url)
  end)
end

return M
