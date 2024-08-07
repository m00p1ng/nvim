local M = {}

M.ui_filetypes = {
  "alpha",
  "help",
  "qf",
  "",
  "notfile",
  "quickfix",
  "lazy",
  "NvimTree",
  "NeogitStatus",
  "NeogitPopup",
  "NeogitCommitPopup",
  "NeogitCommitMessage",
  "NeogitConsole",
  "NeogitNotification",
  "NeogitGitCommandHistory",
  "DiffviewFiles",
  "DiffviewFileHistory",
  "Outline",
  "TelescopePrompt",
  "lspinfo",
  "mason",
  "dapui_watches",
  "dapui_stacks",
  "dapui_breakpoints",
  "dapui_scopes",
  "dapui_hover",
  "dapui_console",
  "dap-repl",
  "noice",
  "startuptime",
  "notify",
  "DressingInput",
}

function M.cmd(args, cwd)
  local result = { stdout = {}, stderr = {} }
  local job = vim.fn.jobstart(args, {
    cwd = cwd,
    on_stdout = function(chanid, data, name)
      for _, line in ipairs(data) do
        if string.len(line) > 0 then
          table.insert(result.stdout, line)
        end
      end
    end,
    on_stderr = function(chanid, data, name)
      for _, line in ipairs(data) do
        if string.len(line) > 0 then
          table.insert(result.stderr, line)
        end
      end
    end,
  })
  vim.fn.jobwait { job }
  return result
end

function M.is_ui_filetype(value, opts)
  opts = opts or {}
  local include = opts.include
  local exclude = opts.exclude

  if include ~= nil then
    return vim.tbl_contains(include, value)
  end

  if exclude ~= nil then
    return not vim.tbl_contains(exclude, value)
  end

  return vim.tbl_contains(M.ui_filetypes, value)
end

function M.clear_prompt()
  vim.api.nvim_command "normal! :<cr>"
end

function M.is_empty(s)
  return s == nil or s == ""
end

function M.find_index(source, value)
  for k, v in pairs(source) do
    if v == value then
      return k
    end
  end
end

function M.get_buf_option(opt)
  local status_ok, buf_option = pcall(vim.api.nvim_get_option_value, opt, { buf = 0 })
  if not status_ok then
    return nil
  else
    return buf_option
  end
end

function M.has(plugin)
  return require("lazy.core.config").plugins[plugin] ~= nil
end

---@param name string
function M.opts(name)
  local plugin = require("lazy.core.config").plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require "lazy.core.plugin"
  return Plugin.values(plugin, "opts", false)
end

return M
