local local_llm = require("plugins.ai.provider.config")

return {
  { import = "plugins.ai.minuet" },
  {
    "minuet-ai.nvim",
    optional = true,
    opts = {
      provider = "openai_compatible",
      provider_options = {
        openai_compatible = {
          model = local_llm.model,
          stream = true,
          end_point = local_llm.host .. "/v1/chat/completions",
          api_key = local_llm.api_key,
          name = local_llm.name,
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
