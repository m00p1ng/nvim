return {
  "Wansmer/sibling-swap.nvim",
  dependencies = { "nvim-treesitter" },
  keys = { "<C-.>", "<C-,>", "<space>.", "<space>," },
  cond = vim.g.vscode == nil,
  opts = {
    allowed_separators = {
      ",",
      ";",
      "and",
      "or",
      "&&",
      "&",
      "||",
      "|",
      "==",
      "===",
      "!=",
      "!==",
      "-",
      "+",
      ["<"] = ">",
      ["<="] = ">=",
      [">"] = "<",
      [">="] = "<=",
    },
    use_default_keymaps = true,
    -- Highlight recently swapped node. Can be boolean or table
    -- If table: { ms = 500, hl_opts = { link = 'IncSearch' } }
    -- `hl_opts` is a `val` from `nvim_set_hl()`
    highlight_node_at_cursor = true,
    -- keybinding for movements to right or left (and up or down, if `allow_interline_swaps` is true)
    keymaps = {
      ["<C-.>"] = "swap_with_right",
      ["<C-,>"] = "swap_with_left",
      ["<space>."] = "swap_with_right_with_opp",
      ["<space>,"] = "swap_with_left_with_opp",
    },
    ignore_injected_langs = false,
    -- allow swaps across lines
    allow_interline_swaps = true,
    -- swaps interline siblings without separators (no recommended, helpful for swaps html-like attributes)
    interline_swaps_without_separator = false,
  },
}
