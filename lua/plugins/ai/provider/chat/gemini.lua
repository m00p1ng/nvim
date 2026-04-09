return {
  { import = "plugins.ai.codecompanion" },
  {
    "codecompanion.nvim",
    optional = true,
    opts = {
      -- NOTE: You don't need model if you're using ACP. They don't take that as a parameter.
      -- ref: https://github.com/olimorris/codecompanion.nvim/issues/2588#issuecomment-3686878906
      -- Waiting for ConfigOptions
      -- https://github.com/google-gemini/gemini-cli/blob/main/packages/cli/src/acp/acpClient.ts#L350-L360
      interactions = {
        chat = {
          adapter = "gemini_cli",
          -- model = "gemini-flash-latest",
        },
        inline = {
          adapter = "gemini_cli",
          -- model = "gemini-flash-latest",
        },
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
  },
}
