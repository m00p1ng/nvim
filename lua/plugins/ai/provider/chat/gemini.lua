return {
  "codecompanion.nvim",
  optional = true,
  opts = {
    interactions = {
      cli = {
        agent = "gemini",
        agents = {
          gemini = {
            cmd = "gemini",
            args = {},
            description = "Gemini CLI",
            provider = "terminal",
          },
        },
      },
    },
  },
}
