return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = { "python" } },
  },
  {
    "williamboman/mason.nvim",
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = { "black" } },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "black" },
      },
      black = {
        prepend_args = { "--fast", "--line-length", "120" },
      },
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    config = function()
      -- ref: https://github.com/mfussenegger/nvim-dap-python#debugpy
      local dap_python = require "dap-python"
      dap_python.setup "uv"
      dap_python.test_runner = "unittest"
    end,
    keys = {
      { "<leader>dn", "<cmd>lua require('dap-python').test_method()<cr>", desc = "Debug method", buffer = true },
    },
  },
}
