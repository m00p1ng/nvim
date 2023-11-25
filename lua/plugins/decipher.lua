return {
  "MisanthropicBit/decipher.nvim",
  lazy = true,
  cond = vim.g.vscode == nil,
  opts = {
    active_codecs = "all", -- Set all codecs as active and useable
    float = { -- Floating window options
      padding = 0, -- Zero padding (does not apply to title if any)
      border = { -- Floating window border
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
      },
      mappings = {
        close = "q", -- Key to press to close the floating window
        apply = "a", -- Key to press to apply the encoding/decoding
        jsonpp = "J", -- Key to prettily format contents as json if possible
        help = "?", -- Toggle help
      },
      title = true, -- Display a title with the codec name
      title_pos = "left", -- Position of the title
      autoclose = true, -- Autoclose floating window if insert mode is activated or the cursor is moved
      enter = false, -- Automatically enter the floating window if opened
      options = {}, -- Options to apply to the floating window contents
    },
  },
}
