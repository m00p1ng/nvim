return {
  { import = "plugins.ai.codecompanion" },
  {
    "codecompanion.nvim",
    optional = true,
    opts = {
      adapters = {
        acp = {
          claude_code = function()
            return require("codecompanion.adapters").extend("claude_code", {
              env = {
                CLAUDE_CODE_OAUTH_TOKEN = "CC_CLAUDE_CODE_OAUTH_TOKEN",
              },
            })
          end,
        },
      },
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
