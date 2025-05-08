return {
  {
    "nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              format = {
                enable = false,
              },
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.fn.expand "$VIMRUNTIME/lua",
                  vim.fn.stdpath "config" .. "/lua",
                },
              },
              hint = { enable = true },
            },
          },
        },
      },
    },
  },
  {
    "nvim-treesitter",
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = { "lua" } },
  },
  {
    "mason.nvim",
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = { "stylua" } },
  },
  {
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
    },
  },

  -- Other extensions
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },
}
