local M = {}

function M.check()
  vim.health.start "m00p1ng"

  if vim.fn.has "nvim-0.10.0" == 1 then
    vim.health.ok "Using Neovim >= 0.10.0"
  else
    vim.health.error "Neovim >= 0.10.0 is required"
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
      vim.health.ok(("`%s` is installed"):format(name))
    else
      vim.health.warn(("`%s` is not installed"):format(name))
    end
  end
end

return M
