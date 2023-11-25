return {
  "akinsho/git-conflict.nvim",
  event = { "BufReadPost", "BufNewFile" },
  cond = vim.g.vscode == nil,
  opts = {
    disable_diagnostics = true,
  },
}
