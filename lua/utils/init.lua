local M = {}

M.ui_filetypes = {
  "help",
  "qf",
  "",
  "notfile",
  "quickfix",
  "checkhealth",
  "lazy",
}

M.add_ui_ft = function(...)
  for _, v in ipairs { ... } do
    if type(v) == "table" then
      for j = 1, #v do
        M.ui_filetypes[#M.ui_filetypes + 1] = v[j]
      end
    else
      M.ui_filetypes[#M.ui_filetypes + 1] = v
    end
  end
end

M.cmd = function(args, cwd)
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

M.is_ui_filetype = function(value, opts)
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

M.clear_prompt = function()
  vim.cmd "normal! :<cr>"
end

M.is_empty = function(s)
  return s == nil or s == ""
end

M.find_index = function(source, value)
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
M.extend = function(t, key, values)
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

M.get_visual = function()
  local _, ls, cs = unpack(vim.fn.getpos "v")
  local _, le, ce = unpack(vim.fn.getpos ".")
  print(vim.inspect(vim.fn.getpos "v"))
  print(vim.inspect(vim.fn.getpos "."))

  -- nvim_buf_get_text requires start and end args be in correct order
  ls, le = math.min(ls, le), math.max(ls, le)
  cs, ce = math.min(cs, ce), math.max(cs, ce)

  return vim.api.nvim_buf_get_text(0, ls - 1, cs - 1, le - 1, ce, {})
end

return M
