return {
  "roobert/f-string-toggle.nvim",
  ft = "python",
  cond = vim.g.vscode == nil,
  enabled = false,
  opts = {
    key_binding = "\\f",
    key_binding_desc = "Toggle f-string",
  },
}
