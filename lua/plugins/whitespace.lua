return {
  "ntpeters/vim-better-whitespace",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    vim.g.better_whitespace_enabled = 1
    vim.g.strip_whitespace_on_save = 0
    vim.g.strip_whitespace_confirm = 0
    vim.g.strip_only_modified_lines = 1
    vim.g.better_whitespace_filetypes_blacklist = require("utils").ui_filetypes
  end,
}
