return {
  "numToStr/Navigator.nvim",
  cond = vim.g.vscode == nil,
  opts = {
    disable_on_zoom = true,
  },
  keys = {
    { "<C-h>", ":lua require('Navigator').left()<cr>", noremap = true, silent = true, desc = "TmuxLeft" },
    { "<C-j>", ":lua require('Navigator').down()<cr>", noremap = true, silent = true, desc = "TmuxDown" },
    { "<C-k>", ":lua require('Navigator').up()<cr>", noremap = true, silent = true, desc = "TmuxUp" },
    { "<C-l>", ":lua require('Navigator').right()<cr>", noremap = true, silent = true, desc = "TmuxRight" },
  },
}
