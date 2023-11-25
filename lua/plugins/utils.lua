return {
  -- measure startuptime
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    cond = vim.g.vscode == nil,
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "MunifTanjim/nui.nvim",
    lazy = true,
    cond = vim.g.vscode == nil,
  },
  {
    "wakatime/vim-wakatime",
    event = "VeryLazy",
    cond = vim.g.vscode == nil,
  },
  {
    "tpope/vim-repeat",
    event = "VeryLazy",
    cond = vim.g.vscode == nil,
  },
}
