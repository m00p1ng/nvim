return {
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    cond = vim.g.vscode == nil,
    opts = {
      enable_autocmd = false,
    },
  },
  {
    "numToStr/Comment.nvim",
    lazy = true,
    opts = {
      mappings = {
        basic = false,
        extra = false,
        extended = false,
      },
      ignore = "^$",
    },
    config = function(_, opts)
      opts.pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
      require("Comment").setup(opts)
    end,
  },
}
