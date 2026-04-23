return {
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
}
