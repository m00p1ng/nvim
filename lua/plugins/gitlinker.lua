local git = require "utils.git"

--- @param s string
--- @param t string
local function string_endswith(s, t)
  return string.len(s) >= string.len(t) and string.sub(s, #s - #t + 1) == t
end

--- @param lk gitlinker.Linker
local function github_router(lk)
  local builder = "https://"
  -- host: 'github.com', 'gitlab.com', 'bitbucket.org'
  builder = builder .. lk.host .. "/"
  -- user: 'linrongbin16', 'neovim'
  builder = builder .. lk.user .. "/"
  -- repo: 'gitlinker.nvim.git', 'neovim'
  builder = builder .. string.gsub(lk.repo, ".git", "") .. "/"
  builder = builder .. "blob/"
  -- rev: git commit, e.g. 'e605210941057849491cca4d7f44c0e09f363a69'
  if git.is_remote_rev() then
    builder = builder .. lk.current_branch .. "/"
  else
    builder = builder .. lk.rev .. "/"
  end
  -- file: 'lua/gitlinker/logger.lua'
  builder = builder .. lk.file .. (string_endswith(lk.file, ".md") and "?plain=1" or "")
  -- line range: start line number, end line number
  builder = builder .. string.format("#L%d", lk.lstart)
  if lk.lend > lk.lstart then
    builder = builder .. string.format("-L%d", lk.lend)
  end
  return builder
end

--- @param lk gitlinker.Linker
local function github_commit_router(lk)
  local builder = "https://"
  -- host: 'github.com', 'gitlab.com', 'bitbucket.org'
  builder = builder .. lk.host .. "/"
  -- user: 'linrongbin16', 'neovim'
  builder = builder .. lk.user .. "/"
  -- repo: 'gitlinker.nvim.git', 'neovim'
  builder = builder .. string.gsub(lk.repo, ".git", "") .. "/"
  builder = builder .. "commit/"
  -- rev: git commit, e.g. 'e605210941057849491cca4d7f44c0e09f363a69'
  local sha = git.get_commit_sha()
  builder = builder .. sha .. "/"

  return builder
end

return {
  "linrongbin16/gitlinker.nvim",
  opts = {
    -- print message in command line
    message = true,

    -- highlights the linked line(s) by the time in ms
    -- disable highlight by setting a value equal or less than 0
    highlight_duration = 500,

    -- user command
    command = {
      -- to copy link to clipboard, use: 'GitLink'
      -- to open link in browser, use bang: 'GitLink!'
      -- to use blame router, use: 'GitLink blame' and 'GitLink! blame'
      name = "GitLink",
      desc = "Generate git permanent link",
    },

    -- router bindings
    router = {
      browse = {
        ["^github%.com"] = github_router,
      },
      project = {
        ["^github%.com"] = "https://{_A.HOST}/{_A.USER}/{_A.REPO}",
      },
      commit = {
        ["^github%.com"] = github_commit_router,
      },
    },

    -- enable debug
    debug = false,

    -- write logs to console(command line)
    console_log = true,

    -- write logs to file
    file_log = false,
  },
  keys = {
    { "<leader>gw", "<cmd>GitLink! commit<cr>", desc = "Open Commit on Web" },
    { "<leader>gy", "<cmd>GitLink!<cr>", desc = "Open Line on Web" },
    { "<leader>gY", "<cmd>GitLink<cr>", desc = "Copy GitLink to Clipboard" },
    { "<leader>gO", "<cmd>GitLink! project<cr>", desc = "Open Project on Web" },

    { "<leader>gy", ":GitLink!<cr>", desc = "Open Line on Web", mode = "v" },
    { "<leader>gY", ":GitLink<cr>", desc = "Copy GitLink to Clipboard", mode = "v" },
  },
}
