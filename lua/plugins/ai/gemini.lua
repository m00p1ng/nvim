return {
  { import = "plugins.ai.codecompanion" },
  {
    "codecompanion.nvim",
    opts = {
      opts = {
        log_level = "DEBUG",
      },
      interactions = {
        chat = {
          adapter = "gemini_cli",
          model = "gemini-flash-latest",
        },
        inline = {
          adapter = "gemini_cli",
          model = "gemini-flash-latest",
        },
      },
      adapters = {
        acp = {
          gemini_cli = function()
            return require("codecompanion.adapters").extend("gemini_cli", {
              defaults = {
                auth_method = "oauth-personal", -- "oauth-personal"|"gemini-api-key"|"vertex-ai"
              },
            })
          end,
        },
      },
    },
  },
}
