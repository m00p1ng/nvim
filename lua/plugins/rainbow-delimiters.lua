return {
  "HiPhish/rainbow-delimiters.nvim",
  cond = vim.g.vscode == nil,
  config = function()
    local rainbow_delimiters = require "rainbow-delimiters"

    vim.g.rainbow_delimiters = {
      strategy = {
        [""] = rainbow_delimiters.strategy["global"],
        vim = rainbow_delimiters.strategy["local"],
      },
      query = {
        [""] = "rainbow-delimiters",
        -- lua = "rainbow-blocks",
      },
      highlight = {
        "RainbowDelimiter1",
        "RainbowDelimiter2",
        "RainbowDelimiter3",
      },
    }
  end,
}
