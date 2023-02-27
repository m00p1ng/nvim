return {
  "akinsho/flutter-tools.nvim",
  ft = "dart",
  opts = {
    -- lsp = {
    --   on_attach = require("user.lsp.handlers").on_attach,
    --   capabilities = require("user.lsp.handlers").capabilities,
    -- },
    closing_tags = {
      highlight = "GitBlame",
    },
    dev_log = {
      open_cmd = "e",
    },
  },
}

-- telescope.load_extension("flutter")
