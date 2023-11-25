return {
  "RRethy/vim-illuminate",
  event = { "BufReadPre", "BufNewFile" },
  cond = vim.g.vscode == nil,
  opts = {
    providers = {
      "lsp",
      "treesitter",
      "regex",
    },
    delay = 120,
    filetypes_denylist = require("utils").ui_filetypes,
    filetypes_allowlist = {},
    modes_denylist = {},
    modes_allowlist = {},
    providers_regex_syntax_denylist = {},
    providers_regex_syntax_allowlist = {},
    under_cursor = true,
  },
  config = function(_, opts)
    require("illuminate").configure(opts)
  end,
}
