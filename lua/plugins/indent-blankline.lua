return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  cond = vim.g.vscode == nil,
  tag = "v2.20.8",
  opts = {
    -- char = "│"
    -- char = "▎"
    char = "▏",
    context_char = "▏",
    show_trailing_blankline_indent = false,
    show_first_indent_level = true,
    use_treesitter = true,
    show_current_context = true,
    buftype_exclude = { "terminal", "nofile" },
    filetype_exclude = require("utils").ui_filetypes,
  },
}
