return {
  {
    "mason-lspconfig.nvim",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = { "marksman" },
    },
  },
  {
    "nvim-treesitter",
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = { "markdown", "markdown_inline" } },
  },

  -- Other extensions
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    opts_extend = { "preview.filetypes" },
    opts = {
      preview = {
        enable = true,
        filetypes = { "markdown" },
        modes = { "n", "no", "c" },
        hybrid_modes = { "n" },
        callbacks = {
          on_mode_change = function(buf, wins, current_mode)
            local markview = require "markview"

            local ft = vim.bo[buf].ft
            if ft == "markdown" then
              markview.actions.disable(buf)
            end
          end,
        },
      },
      markdown = {
        headings = {
          shift_width = 1,
          heading_1 = { sign = "" },
          heading_2 = { sign = "" },
        },
        code_blocks = {
          sign = false,
        },
        list_items = {
          shift_width = 2,
        },
      },
      latex = false,
      experimental = {
        check_rtp = false,
      },
    },
    keys = {
      { "<leader>mt", "<cmd>Markview<cr>", desc = "Toggle preview", buffer = true, ft = { "markdown" } },
      { "<leader>ms", "<cmd>Markview splitToggle<cr>", desc = "Toggle split", buffer = true, ft = { "markdown" } },
    },
  },

  {
    "timantipov/md-table-tidy.nvim",
    -- default config
    opts = {
      padding = 1, -- number of spaces for cell padding
      keymap = {
        table_tidy = "<leader>mb", -- key for command :TableTidy<CR>
        table_tidy_all = "<leader>ma", -- key for command :TableTidyAll<CR>
      },
    },
  },
}
