return {
  { import = "plugins.ai.minuet" },
  {
    "minuet-ai.nvim",
    optional = true,
    opts = {
      provider = "gemini",
      provider_options = {
        gemini = {
          model = "gemini-flash-latest",
          optional = {
            generationConfig = {
              maxOutputTokens = 256,
              thinkingConfig = {
                -- Disable thinking for gemini 2.5 models
                -- thinkingBudget = 0,

                -- Disable thinking for gemini 3.x models
                thinkingLevel = "minimal",

                -- Setting only one of the above options is sufficient.
              },
            },
            safetySettings = {
              {
                -- HARM_CATEGORY_HATE_SPEECH,
                -- HARM_CATEGORY_HARASSMENT
                -- HARM_CATEGORY_SEXUALLY_EXPLICIT
                category = "HARM_CATEGORY_DANGEROUS_CONTENT",
                -- BLOCK_NONE
                threshold = "BLOCK_ONLY_HIGH",
              },
            },
          },
        },
      },
    },
  },

  { import = "plugins.ai.codecompanion" },
  {
    "codecompanion.nvim",
    optional = true,
    opts = {
      -- NOTE: You don't need model if you're using ACP. They don't take that as a parameter.
      -- ref: https://github.com/olimorris/codecompanion.nvim/issues/2588#issuecomment-3686878906
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
