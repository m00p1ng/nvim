return {
  "folke/paint.nvim",
  event = { "BufReadPost", "BufNewFile" },
  cond = vim.g.vscode == nil,
  opts = {
    highlights = {
      {
        -- filter can be a table of buffer options that should match,
        -- or a function called with buf as param that should return true.
        -- The example below will paint @something in comments with Constant
        filter = { filetype = "lua" },
        pattern = "%s*%-%-%-%s*(@%w+)",
        hl = "Constant",
      },
      {
        filter = { filetype = "go" },
        pattern = "%s*//%s*(@%w+)",
        hl = "Constant",
      },
    },
  },
}
