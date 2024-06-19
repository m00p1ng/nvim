return {
  "ur4ltz/surround.nvim",
  event = { "BufReadPost", "BufNewFile" },
  cond = vim.g.vscode == nil,
  opts = {
    context_offset = 100,
    load_autogroups = false,
    mappings_style = "surround",
    map_insert_mode = false,
    quotes = { "'", '"' },
    brackets = { "(", "{", "[" },
    pairs = {
      nestable = { { "(", ")" }, { "[", "]" }, { "{", "}" } },
      linear = { { "'", "'" }, { "`", "`" }, { '"', '"' } },
    },
    prefix = "s",
  },
}
