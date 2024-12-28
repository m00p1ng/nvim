return {
  "numToStr/Navigator.nvim",
  opts = {
    disable_on_zoom = true,
  },
  keys = {
    { "<C-h>", "<cmd>lua require('Navigator').left()<cr>", desc = "Tmux Left" },
    { "<C-j>", "<cmd>lua require('Navigator').down()<cr>", desc = "Tmux Down" },
    { "<C-k>", "<cmd>lua require('Navigator').up()<cr>", desc = "Tmux Up" },
    { "<C-l>", "<cmd>lua require('Navigator').right()<cr>", desc = "Tmux Right" },
  },
}
