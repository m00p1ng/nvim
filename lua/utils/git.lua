local git = require("gitlinker.git")
local actions = require("gitlinker.actions")
local cmd = require("utils").cmd

local M = {}

local function get_git_commit_sha()
  local lnum = vim.api.nvim_win_get_cursor(0)[1]
  local filepath = vim.api.nvim_buf_get_name(0)

  local result = cmd({
    "git",
    "--no-pager",
    "blame",
    "-L" .. lnum .. "," .. lnum,
    "-l",
    "-s",
    filepath,
  })

  local text = result.stdout[1]
  if text == nil then
    return nil
  end

  return string.sub(text, 1, 40)
end

local function parse_git_url(remote_url)
  local domain, path = string.match(remote_url, ".*git%@(.*)%:(.*)%.git")
  if domain and path then
    return "https://" .. domain .. "/" .. path
  end

  local url = string.match(remote_url, ".*git%@(.*)%.git")
  if url then
    return "https://" .. url
  end

  local https_url = string.match(remote_url, "(https%:%/%/.*)%.git")
  if https_url then
    return https_url
  end

  -- Don't have .git extension
  domain, path = string.match(remote_url, ".*git%@(.*)%:(.*)")
  if domain and path then
    return "https://" .. domain .. "/" .. path
  end

  url = string.match(remote_url, ".*git%@(.*)")
  if url then
    return "https://" .. url
  end

  https_url = string.match(remote_url, "(https%:%/%/.*)")
  if https_url then
    return https_url
  end
end

local function get_remote_url()
  local remote = git.get_branch_remote()
  local remote_url = git.get_remote_url(remote)
  return parse_git_url(remote_url.stdout[1])
end

function M.git_previous_change()
  local sha = get_git_commit_sha()
  vim.api.nvim_command(":DiffviewOpen " .. sha .. "^!")
end

function M.open_git_commit_on_web()
  local remote_url = get_remote_url()
  local sha = get_git_commit_sha()
  local commit_path = "commit/" .. sha

  actions.system(remote_url .. '/' .. commit_path)
end

function M.open_git_project_on_web()
  local remote_url = get_remote_url()
  actions.system(remote_url)
end

return M
