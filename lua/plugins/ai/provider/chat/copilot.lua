return {
  { import = "plugins.ai.codecompanion" },
  {
    "codecompanion.nvim",
    optional = true,
    opts = {
      adapters = {
        acp = {
          -- NOTE: https://github.com/olimorris/codecompanion.nvim/issues/2969#issuecomment-4185096133
          copilot_acp = function()
            return require("codecompanion.adapters").extend("copilot_acp", {
              defaults = {
                model = "gpt-5-mini",
              },
            })
          end,
        },
      },
      interactions = {
        chat = {
          adapter = "copilot_acp",
          model = "gpt-5-mini",
        },
        inline = {
          adapter = "copilot",
          model = "claude-sonnet-4.6",
        },
        cli = {
          agent = "copilot",
          agents = {
            copilot = {
              cmd = "copilot",
              args = {},
              description = "GitHub Copilot CLI",
              provider = "terminal",
            },
          },
        },
      },
    },
  },
}
