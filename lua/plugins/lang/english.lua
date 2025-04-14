return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        harper_ls = {
          settings = {
            ["harper-ls"] = {
              linters = {
                LongSentences = false,
                SentenceCapitalization = false,
                SpellCheck = false,
              },
            },
          },
        },
      },
    },
  },
}
