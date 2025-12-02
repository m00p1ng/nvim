return {
  {
    "ellisonleao/dotenv.nvim",
    cmd = "Dotenv",
    init = function()
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        pattern = { ".env.*", "*.env" },
        callback = function(event)
          vim.cmd.Dotenv(event.file)
        end,
      })
    end,
    opts = {},
    keys = function()
      vim.g.last_env = nil

      local function select_env()
        local result = vim
          .system({ "fd", "-t", "f", "--no-ignore-vcs", "--hidden", "^\\.env\\..*|.*\\.env$" }, { text = true })
          :wait()
        if result.code ~= 0 then
          vim.notify("Cannot find .env, please try again later", vim.log.levels.WARN)
          return
        end

        local ret = vim.trim(result.stdout)
        if ret == "" then
          vim.notify(".env was not found", vim.log.levels.WARN)
          return
        end

        local envs = vim.split(ret, "\n")
        vim.ui.select(envs, {
          prompt = "Select environment:",
        }, function(choice)
          if not choice then
            return
          end
          vim.cmd.Dotenv(choice)
          vim.notify("Loaded " .. choice, vim.log.levels.INFO)
          vim.g.last_env = choice
        end)
      end

      local function reload_env()
        if vim.g.last_env then
          vim.cmd.Dotenv(vim.g.last_env)
          vim.notify("Reloaded " .. vim.g.last_env, vim.log.levels.INFO)
        else
          select_env()
        end
      end

      return {
        { "<leader>V", select_env, desc = "DotENV: Load" },
        { "<leader>v", reload_env, desc = "DotENV: Reload" },
      }
    end,
  },
}
