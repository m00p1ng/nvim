return {
  "kevinhwang91/nvim-bqf",
  event = "VeryLazy",
  cond = vim.g.vscode == nil,
  opts = {
    auto_enable = true,
    auto_resize_height = false, -- highly recommended enable
    preview = {
      win_height = 30,
      win_vheight = 30,
    },
  },
}
