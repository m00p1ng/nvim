return {
  "vidocqh/auto-indent.nvim",
  event = "InsertEnter",
  opts = {
    lightmode = true, -- Lightmode assumes tabstop and indentexpr not change within buffer's lifetime
    indentexpr = nil, -- Use vim.bo.indentexpr by default, see 'Custom Indent Evaluate Method'
    ignore_filetype = {}, -- Disable plugin for specific filetypes,
  },
}
