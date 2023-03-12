local ts_utils = require'nvim-treesitter.ts_utils'

local M = {}

local get_line_for_node = function(node)
  local type_patterns = {'class', 'function', 'method'}
  local node_type = node:type()
  local is_valid = false
  for _, rgx in ipairs(type_patterns) do
    if node_type:find(rgx) then
      is_valid = true
      break
    end
  end
  if not is_valid then return '' end
  return vim.trim(vim.treesitter.query.get_node_text(node:child(1), vim.api.nvim_get_current_buf()) or '')
end

function M.get_ref()
  local current_node = ts_utils.get_node_at_cursor()
  if not current_node then return "" end

  local lines = {}
  local expr = current_node

  while expr do
    local line = get_line_for_node(expr)
    if line ~= '' and not vim.tbl_contains(lines, line) then
      table.insert(lines, 1, line)
    end
    expr = expr:parent()
  end

  return table.concat(lines, '.')
end

return M
