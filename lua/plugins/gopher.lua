return {
  "olexsmir/gopher.nvim",
  build = ":GoInstallDeps",
  ft = "go",
  cond = vim.g.vscode == nil,
  config = true,
}
