return {
  "akinsho/git-conflict.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    disable_diagnostics = true,
  },
}
