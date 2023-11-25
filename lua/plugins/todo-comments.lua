local icons = require "utils.icons"

return {
  "folke/todo-comments.nvim",
  event = { "BufReadPost", "BufNewFile" },
  cond = vim.g.vscode == nil,
  opts = {
    signs = true,
    sign_priority = 8,
    keywords = {
      FIX = {
        icon = icons.ui.Bug,
        color = "#F44747",
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
      },
      TODO = { icon = icons.ui.Check, color = "#4FC1FF", alt = { "TIP" } },
      HACK = { icon = icons.ui.Fire, color = "#ff8800" },
      WARN = { icon = icons.diagnostics.Warning, color = "#ff8800", alt = { "WARNING", "XXX" } },
      PERF = { icon = icons.ui.Dashboard, color = "#7C3AED", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = icons.ui.Note, color = "#FFCC66", alt = { "INFO" } },
    },
    highlight = {
      before = "",
      keyword = "wide",
      after = "fg",
      pattern = [[.*<(KEYWORDS)\s*:]],
      comments_only = true,
      max_line_len = 400,
      exclude = {},
    },
    search = {
      command = "rg",
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },
      pattern = [[\b(KEYWORDS):]],
    },
  },
}
