return {
  "mawkler/demicolon.nvim",
  opts = {
    -- Create default keymaps
    keymaps = {
      -- Create t/T/f/F key mappings
      horizontal_motions = true,
      -- Create ; and , key mappings. Set it to 'stateless', 'stateful', or false to
      -- not create any mappings. 'stateless' means that ;/, move right/left.
      -- 'stateful' means that ;/, will remember the direction of the original
      -- jump, and `,` inverts that direction (Neovim's default behaviour).
      repeat_motions = "stateless",
      -- Keys that shouldn't be repeatable (because aren't motions), excluding the prefix `]`/`[`
      -- If you have custom motions that use one of these, make sure to remove that key from here
      disabled_keys = { "I", "A", "f", "i" },
    },
  },
}
