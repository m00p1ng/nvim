return {
  "mcauley-penney/visual-whitespace.nvim",
  cond = vim.g.vscode == nil,
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    highlight = { bg = "#264f78", fg = "#808080" },
    space_char = "·",
    tab_char = "→",
    nl_char = "",
    cr_char = "←",
  },
}
