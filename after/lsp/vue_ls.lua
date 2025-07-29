-- ref: https://minerva.mamansoft.net/Notes/%F0%9F%93%9C2025-07-07+Neovim+nvim-lspconfig%E3%81%A7Vue+Language+Tools+%E3%82%92+v2+%E3%81%8B%E3%82%89+v3+%E3%81%AB%E3%82%A2%E3%83%83%E3%83%97%E3%83%87%E3%83%BC%E3%83%88%E3%81%99%E3%82%8B
--      https://github.com/vuejs/language-tools/wiki/Neovim
return {
  settings = {
    html = {
      format = {
        -- https://github.com/vuejs/language-tools/discussions/988#discussioncomment-10196446
        wrapAttributes = "preserve-aligned",
      },
    },
  },
}
