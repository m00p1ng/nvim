return {
  "codecompanion.nvim",
  optional = true,
  opts = {
    adapters = {
      acp = {
        kimi_cli = function()
          return require("codecompanion.adapters").extend("kimi_cli", {})
        end,
      },
    },
    interactions = {
      cli = {
        agent = "kimi_cli",
        agents = {
          kimi_cli = {
            cmd = "kimi",
            args = {},
            description = "Kimi CLI",
            provider = "terminal",
          },
        },
      },
    },
  },
}
