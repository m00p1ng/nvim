local actions = require "gitlinker.actions"
local linker = require "gitlinker.linker"
local cmd = require("utils").cmd

local M = {}

local function get_git_commit_sha()
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

local function get_remote_url()
  local lk = linker.make_linker()
  if lk == nil then
    return "http://localhost/404"
  end

  return "https://" .. lk.host .. "/" .. lk.user .. "/" .. string.gsub(lk.repo, ".git", "") .. "/"
end

function M.previous_change()
  local sha = get_git_commit_sha()
  vim.api.nvim_command(":DiffviewOpen " .. sha .. "^!")
end

function M.open_commit_on_web()
  local remote_url = get_remote_url()
  local sha = get_git_commit_sha()
  local commit_path = "commit/" .. sha

  actions.system(remote_url .. "/" .. commit_path)
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

  print(vim.inspect(result))

  return result.stdout[1] ~= nil
end

return M
