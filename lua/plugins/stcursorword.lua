return {
  "sontungexpt/stcursorword",
  event = { "BufReadPre", "BufNewFile" },
  cond = vim.g.vscode == nil,
  opts = {
    max_word_length = 100, -- if cursorword length > max_word_length then not highlight
    min_word_length = 2, -- if cursorword length < min_word_length then not highlight
    excluded = {
      filetypes = require("utils").ui_filetypes,
      buftypes = {
        -- "nofile",
        -- "terminal",
      },
      file_patterns = { -- the pattern to match with the file path
        -- "%.png$",
        -- "%.jpg$",
        -- "%.jpeg$",
        -- "%.pdf$",
        -- "%.zip$",
        -- "%.tar$",
        -- "%.tar%.gz$",
        -- "%.tar%.xz$",
        -- "%.tar%.bz2$",
        -- "%.rar$",
        -- "%.7z$",
        -- "%.mp3$",
        -- "%.mp4$",
      },
    },
    highlight = {
      underline = false,
      fg = "NONE",
      bg = "#363636",
    },
  },
}
