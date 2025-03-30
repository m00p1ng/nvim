return {
  "mawkler/demicolon.nvim",
  -- keys = { ';', ',', 't', 'f', 'T', 'F', ']', '[', ']d', '[d' }, -- Uncomment this to lazy load
  opts = {
    diagnostic = {
      -- See `:help vim.diagnostic.Opts.Float`
      float = {},
    },
    -- Create default keymaps
    keymaps = {
      -- Create t/T/f/F key mappings
      horizontal_motions = true,
      -- Create ]d/[d, etc. key mappings to jump to diagnostics. See demicolon.keymaps.create_default_diagnostic_keymaps
      diagnostic_motions = false,
      -- Create ; and , key mappings
      repeat_motions = true,
      -- Create ]q/[q/]<C-q>/[<C-q> and ]l/[l/]<C-l>/[<C-l> quickfix and location list mappings
      list_motions = false,
      -- Create `]s`/`[s` key mappings for jumping to spelling mistakes
      spell_motions = false,
      -- Create `]z`/`[z` key mappings for jumping to folds
      fold_motions = false,
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
      -- Integration with https://github.com/nvim-neotest/neotest
      neotest = {
        enabled = false,
        keymaps = {
          test = {
            next = "]t",
            prev = "[t",
          },
          failed_test = {
            next = "]T",
            prev = "[T",
          },
        },
      },
      -- Integration with https://github.com/lervag/vimtex
      vimtex = {
        enabled = false,
        keymaps = {
          section_start = {
            next = "]]",
            prev = "[[",
          },
          section_end = {
            next = "][",
            prev = "[]",
          },
          frame_start = {
            next = "]r",
            prev = "[r",
          },
          frame_end = {
            next = "]R",
            prev = "[R",
          },
          math_start = {
            next = "]n",
            prev = "[n",
          },
          math_end = {
            next = "]N",
            prev = "[N",
          },
          comment_start = {
            next = "]/",
            prev = "[/",
          },
          comment_end = {
            next = "]*",
            prev = "[*",
          },
          environment_start = {
            next = "]m",
            prev = "[m",
          },
          environment_end = {
            next = "]M",
            prev = "[M",
          },
        },
      },
    },
  },
}
