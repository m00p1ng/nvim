return {
  "windwp/nvim-ts-autotag",
  event = "InsertEnter",
  cond = vim.g.vscode == nil,
  opts = {
    enable = true,
    enable_rename = true,
    enable_close = true,
    enable_close_on_slash = true,
  },
}
