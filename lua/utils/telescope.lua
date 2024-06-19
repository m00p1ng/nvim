local M = {}

function M.project_files(opts)
  local ok = pcall(require("telescope.builtin").git_files, opts)
  if not ok then
    require("telescope.builtin").find_files(opts)
  end
end

function M.grep_at_current_tree_node()
  local node = require("nvim-tree.lib").get_node_at_cursor()
  if not node then
    return
  end
  require("telescope.builtin").live_grep { search_dirs = { node.absolute_path } }
end

return M
