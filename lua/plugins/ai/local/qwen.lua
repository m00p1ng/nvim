local qwen = {
  model = "qwen3-coder-30b-a3b-instruct-mlx",
  host = "http://localhost:11434",
  api_key = "TERM",
}

return {
  { import = "plugins.ai.minuet" },
  {
    "minuet-ai.nvim",
    optional = true,
    opts = function()
      return {
        provider = "openai_compatible",
        n_completions = 1, -- recommend for local model for resource saving
        -- I recommend beginning with a small context window size and incrementally
        -- expanding it, depending on your local computing power. A context window
        -- of 512, serves as an good starting point to estimate your computing
        -- power. Once you have a reliable estimate of your local computing power,
        -- you should adjust the context window to a larger value.
        context_window = 512,
        provider_options = {
          openai_compatible = {
            model = qwen.model,
            system = require("minuet.config").default_system,
            few_shots = require("minuet.config").default_few_shots,
            chat_input = require("minuet.config").default_chat_input,
            stream = true,
            end_point = qwen.host .. "/v1/chat/completions",
            api_key = qwen.api_key,
            name = "Qwen3 Coder",
          },
        },
      }
    end,
  },

  { import = "plugins.ai.codecompanion" },
  {
    "codecompanion.nvim",
    optional = true,
    opts = {
      interactions = {
        chat = { adapter = "qwen3_local" },
        inline = { adapter = "qwen3_local" },
      },
      adapters = {
        http = {
          qwen3_local = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              schema = {
                model = {
                  default = qwen.model,
                },
              },
              env = {
                url = qwen.host,
                api_key = qwen.api_key,
                chat_url = "/v1/chat/completions",
              },
            })
          end,
        },
      },
    },
  },
}
