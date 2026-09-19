return {
  "numToStr/Navigator.nvim",
  opts = {
    disable_on_zoom = true,
  },
  keys = {
    { "<C-h>", "<cmd>NavigatorLeft<cr>", desc = "Tmux Left", mode = { "n", "t" } },
    { "<C-j>", "<cmd>NavigatorDown<cr>", desc = "Tmux Down", mode = { "n", "t" } },
    { "<C-k>", "<cmd>NavigatorUp<cr>", desc = "Tmux Up", mode = { "n", "t" } },
    { "<C-l>", "<cmd>NavigatorRight<cr>", desc = "Tmux Right", mode = { "n", "t" } },
  },
}
