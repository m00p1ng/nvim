return {
  "numToStr/Comment.nvim",
  event = { "BufReadPost", "BufNewFile" },
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
}
