return {
  "HiPhish/rainbow-delimiters.nvim",
  event = { "BufReadPost", "BufNewFile" },
  init = function()
    local rainbow_delimiters = require "rainbow-delimiters"

    ---@type rainbow_delimiters.config
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
        "RainbowDelimiterRed",
        "RainbowDelimiterOrange",
        "RainbowDelimiterYellow",
        "RainbowDelimiterGreen",
        "RainbowDelimiterBlue",
        "RainbowDelimiterViolet",
      },
      condition = function(bufnr)
        local limit = 100 * 1024 -- 100KB
        local file_size = vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr))

        return file_size < limit
      end,
    }
  end,
}
