local cmd = require("utils").cmd

local M = {}

function M.get_commit_sha()
  local lnum = vim.api.nvim_win_get_cursor(0)[1]
  local filepath = vim.api.nvim_buf_get_name(0)

  local result = cmd {
    "git",
    "--no-pager",
    "blame",
    "-L" .. lnum .. "," .. lnum,
    "-l",
    "-s",
    filepath,
  }

  local text = result.stdout[1]
  if text == nil then
    return nil
  end

  return string.sub(text, 1, 40)
end

function M.previous_change()
  local sha = M.get_commit_sha()
  vim.cmd.DiffviewOpen { sha .. "^!" }
end

--- @return boolean
function M.is_remote_rev()
  local result = cmd {
    "git",
    "rev-parse",
    "--abbrev-ref",
    "--symbolic-full-name",
    "@{u}",
  }

  return result.stdout[1] ~= nil
end

return M
