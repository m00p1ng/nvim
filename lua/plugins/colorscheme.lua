return {
  "m00p1ng/darkplus.nvim",
  cond = vim.g.vscode == nil,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme "darkplus"
  end,
}
