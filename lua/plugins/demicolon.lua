return {
  "mawkler/demicolon.nvim",
  opts = {
    -- Create default keymaps
    keymaps = {
      -- Create t/T/f/F key mappings
      horizontal_motions = true,
      -- Create ; and , key mappings
      repeat_motions = true,
      -- Keys that shouldn't be repeatable (because aren't motions), excluding the prefix `]`/`[`
      -- If you have custom motions that use one of these, make sure to remove that key from here
      disabled_keys = { "I", "A", "f", "i" },
    },
  },
}
