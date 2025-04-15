M = {}

M.last_env = nil

M.select_env = function()
  local result = vim
    .system({ "fd", "-t", "f", "--no-ignore-vcs", "--hidden", "^\\.env\\..*|.*\\.env$" }, { text = true })
    :wait()
  if result.code ~= 0 then
    vim.notify(".env was not found", vim.log.levels.WARN)
    return
  end

  local envs = vim.split(vim.trim(result.stdout), "\n")
  vim.ui.select(envs, {
    prompt = "Select environment:",
  }, function(choice)
    if not choice then
      return
    end
    vim.cmd.Dotenv(choice)
    vim.notify("Loaded " .. choice, vim.log.levels.INFO)
    M.last_env = choice
  end)
end

M.reload_env = function()
  if M.last_env then
    vim.cmd.Dotenv(M.last_env)
    vim.notify("Reloaded " .. M.last_env, vim.log.levels.INFO)
  else
    M.select_env()
  end
end

return {
  {
    "ellisonleao/dotenv.nvim",
    opts = {},
    init = function()
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        pattern = { ".env.*", "*.env" },
        callback = function(event)
          vim.cmd.Dotenv(event.file)
        end,
      })
    end,
    keys = {
      { "<leader>V", M.select_env, desc = "Dotenv: Load" },
      { "<leader>v", M.reload_env, desc = "Dotenv: Reload" },
    },
  },
}
