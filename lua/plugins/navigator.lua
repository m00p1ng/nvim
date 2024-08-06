return {
  "numToStr/Navigator.nvim",
  opts = {
    disable_on_zoom = true,
  },
  keys = {
    { "<C-h>", ":lua require('Navigator').left()<cr>", desc = "Tmux Left" },
    { "<C-j>", ":lua require('Navigator').down()<cr>", desc = "Tmux Down" },
    { "<C-k>", ":lua require('Navigator').up()<cr>", desc = "Tmux Up" },
    { "<C-l>", ":lua require('Navigator').right()<cr>", desc = "Tmux Right" },
  },
}
