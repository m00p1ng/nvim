return {
  -- depends on the TypeScript extra
  { import = "plugins.lang.typescript" },

  {
    "mason-lspconfig.nvim",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = { "vue_ls" },
    },
  },

  {
    "nvim-treesitter",
    opts = { ensure_installed = { "vue", "css", "scss" } },
  },
}
