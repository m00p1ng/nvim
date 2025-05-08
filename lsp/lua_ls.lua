return {
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
}
