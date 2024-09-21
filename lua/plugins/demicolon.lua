return {
  "mawkler/demicolon.nvim",
  -- keys = { ';', ',', 't', 'f', 'T', 'F', ']', '[', ']d', '[d' }, -- Uncomment this to lazy load
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  opts = {
    diagnostic = {
      -- See `:help vim.diagnostic.Opts.Float`
      float = {},
    },
    -- Create default keymaps
    keymaps = {
      -- Create `t`/`T`/`f`/`F` key mappings
      horizontal_motions = true,
      -- Create ]d/[d, etc. key mappings to jump to diganostics. See demicolon.keymaps.create_default_diagnostic_keymaps
      diagnostic_motions = true,
      -- Create `;` and `,` key mappings
      repeat_motions = true,
    },
    integrations = {
      -- Integration with https://github.com/lewis6991/gitsigns.nvim
      gitsigns = {
        enabled = true,
        keymaps = {
          next = "]c",
          prev = "[c",
        },
      },
    },
  },
}
