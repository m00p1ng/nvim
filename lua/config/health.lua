local M = {}

function M.check()
  vim.health.report_start "m00p1ng"

  if vim.fn.has "nvim-0.9.5" == 1 then
    vim.health.report_ok "Using Neovim >= 0.9.5"
  else
    vim.health.report_error "Neovim >= 0.9.5 is required"
  end

  local cmds = {
    "git",
    "gh",
    "rg",
    { "fd", "fdfind" },
    "fzf",
    "tree-sitter",
  }

  for _, cmd in ipairs(cmds) do
    local name = type(cmd) == "string" and cmd or vim.inspect(cmd)
    local commands = type(cmd) == "string" and { cmd } or cmd
    ---@cast commands string[]
    local found = false

    for _, c in ipairs(commands) do
      if vim.fn.executable(c) == 1 then
        name = c
        found = true
      end
    end

    if found then
      vim.health.report_ok(("`%s` is installed"):format(name))
    else
      vim.health.report_warn(("`%s` is not installed"):format(name))
    end
  end
end

return M
