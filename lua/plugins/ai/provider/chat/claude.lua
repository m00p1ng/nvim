return {
  { import = "plugins.ai.codecompanion" },
  {
    "codecompanion.nvim",
    optional = true,
    opts = {
      interactions = {
        chat = {
          adapter = "claude_code",
        },
        inline = {
          adapter = "claude_code",
        },
        cli = {
          agent = "claude_code",
          agents = {
            claude = {
              cmd = "claude_code",
              args = {},
              description = "Claude Code",
              provider = "terminal",
            },
          },
        },
      },
    },
  },
}
