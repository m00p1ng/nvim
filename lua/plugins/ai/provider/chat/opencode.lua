return {
  { import = "plugins.ai.codecompanion" },
  {
    "codecompanion.nvim",
    optional = true,
    opts = {
      interactions = {
        chat = {
          adapter = "opencode",
        },
        cli = {
          agent = "opencode",
          agents = {
            opencode = {
              cmd = "opencode",
              args = {},
              description = "OpenCode CLI",
              provider = "terminal",
            },
          },
        },
      },
    },
  },
}
