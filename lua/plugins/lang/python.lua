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
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    config = function()
      -- ref: https://github.com/mfussenegger/nvim-dap-python#debugpy
      local dap_python = require "dap-python"
      dap_python.setup "~/.virtualenvs/debugpy/bin/python"
      dap_python.test_runner = "unittest"
    end,
    keys = {
      { "<leader>dn", require("dap-python").test_method, desc = "Debug method", buffer = true },
    },
  },
}
