return {
  "nvim-treesitter/nvim-treesitter",
  -- ref: https://github.com/nvim-treesitter/nvim-treesitter/issues/4945
  -- commit = "f2778bd1a28b74adf5b1aa51aa57da85adfa3d16",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      -- commit = "35a60f093fa15a303874975f963428a5cd24e4a0",
    },
  },
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  keys = {
    { "<c-q>", desc = "Increment selection" },
    { "<bs>", desc = "Shrink selection", mode = "x" },
  },
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "gitcommit",
      "html",
      "javascript",
      "json",
      "jsonc",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "regex",
      "tsx",
      "typescript",
      "vim",
      "yaml",
    },
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      -- disable = function(lang, buf)
      --   local max_filesize = 100 * 1024 -- 100 KB
      --   local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      --   if ok and stats and stats.size > max_filesize then
      --     return true
      --   end
      -- end,
    },
    indent = {
      enable = true, -- not stable yet
      disable = {
        "yaml",
        -- https://github.com/akinsho/flutter-tools.nvim/issues/267#issuecomment-1616728174
        -- NOTE: enabling indentation significantly slows down editing in Dart files
        "dart",
      },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<c-q>",
        node_incremental = "<c-q>",
        scope_incremental = "<nop>",
        node_decremental = "<bs>",
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["aC"] = "@class.outer",
          ["iC"] = "@class.inner",
          ["ac"] = "@conditional.outer",
          ["ic"] = "@conditional.inner",
          ["ae"] = "@block.outer",
          ["ie"] = "@block.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
          ["is"] = "@statement.inner",
          ["as"] = "@statement.outer",
          ["ad"] = "@comment.outer",
          ["am"] = "@call.outer",
          ["im"] = "@call.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
