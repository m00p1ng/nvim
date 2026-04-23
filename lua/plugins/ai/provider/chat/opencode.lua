return {
  "codecompanion.nvim",
  optional = true,
  opts = {
    adapters = {
      acp = {
        opencode = function()
          return require("codecompanion.adapters").extend("opencode", {})
        end,
      },
    },
    interactions = {
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
}
