local local_llm = {
  name = "qwen3-coder",
  model = "qwen3-coder-30b-a3b-instruct-mlx",
  host = "http://localhost:11434",
  api_key = "TERM",
}

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

  { import = "plugins.ai.codecompanion" },
  {
    "codecompanion.nvim",
    optional = true,
    opts = {
      interactions = {
        chat = { adapter = local_llm.name },
        inline = { adapter = local_llm.name },
      },
      adapters = {
        http = {
          [local_llm.name] = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              schema = {
                model = {
                  default = local_llm.model,
                  name = local_llm.name,
                },
              },
              env = {
                url = local_llm.host,
                api_key = local_llm.api_key,
                chat_url = "/v1/chat/completions",
              },
            })
          end,
        },
      },
    },
  },
}
