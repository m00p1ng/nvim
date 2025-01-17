local M = {}

M.ui_filetypes = {
  "snacks_dashboard",
  "snacks_notif",
  "snacks_notif_history",
  "help",
  "qf",
  "",
  "notfile",
  "quickfix",
  "checkhealth",
  "lazy",
  "NvimTree",
  "neo-tree",
  "neo-tree-popup",
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
  "DressingInput",
  "oil",
  "oil_preview",
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
  local include = opts.include or {}
  local exclude = opts.exclude or {}

  if vim.tbl_contains(include, value) then
    return true
  end

  if vim.tbl_contains(exclude, value) then
    return false
  end

  return vim.tbl_contains(M.ui_filetypes, value)
end

function M.clear_prompt()
  vim.cmd "normal! :<cr>"
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

--- This extends a deeply nested list with a key in a table
--- that is a dot-separated string.
--- The nested list will be created if it does not exist.
---@generic T
---@param t T[]
---@param key string
---@param values T[]
---@return T[]?
function M.extend(t, key, values)
  local keys = vim.split(key, ".", { plain = true })
  for i = 1, #keys do
    local k = keys[i]
    t[k] = t[k] or {}
    if type(t) ~= "table" then
      return
    end
    t = t[k]
  end
  return vim.list_extend(t, values)
end

return M
