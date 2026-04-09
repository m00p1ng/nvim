return {
  { import = "plugins.ai.minuet" },
  {
    "minuet-ai.nvim",
    optional = true,
    opts = {
      provider = "openai_compatible",
      provider_options = {
        openai_compatible = {
          model = "glm-4.5-air",
          stream = true,
          end_point = "https://api.z.ai/api/coding/paas/v4/chat/completions",
          api_key = "OPENAI_API_KEY",
          name = "Z.ai",
          optional = {
            stop = { "\n\n" },
            max_tokens = 256,
          },
          -- a list of functions to transform the endpoint, header, and request body
          transform = {},
        },
      },
    },
  },
}
